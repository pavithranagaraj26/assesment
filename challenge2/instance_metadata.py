import subprocess
import json
import shlex
import os
from urllib.parse import unquote, urlparse
from pathlib import PurePosixPath


# For each project id in the list, get the instance details
def instance_metadata(project_id,project_name):
    output = []
    external_ip = "NA"
    list_instance = "gcloud compute instances list --format json --project "+ project_id
    instance_list_op = json.loads(subprocess.check_output(shlex.split(list_instance)))
    # For every instance in the list get the labels and metadata as required
    for instance_row in instance_list_op:
        creationTimestamp = instance_row["creationTimestamp"]
        instance_name = instance_row["name"]
        vpc = os.path.basename(instance_row["networkInterfaces"][0]["network"]).split('/')[-1]
        vpc_subnet = os.path.basename(instance_row["networkInterfaces"][0]["subnetwork"]).split('/')[-1]
        preemptible = instance_row["scheduling"]["preemptible"]
        status = instance_row["status"]
        zone = os.path.basename(instance_row["zone"]).split('/')[-1]
        region = PurePosixPath(unquote(urlparse(instance_row["networkInterfaces"][0]["subnetwork"]).path)).parts[6]
        internal_ip = instance_row["networkInterfaces"][0]["networkIP"]
        if status != "TERMINATED":
            external_ip = instance_row["networkInterfaces"][0]["accessConfigs"][0]["natIP"]
        metadata = {"project_name":project_name,
                    "project_id":project_id,
                    "creationTimestamp":creationTimestamp,
                    "instance_name":instance_name,
                    "vpc":vpc,
                    "vpc_subnet":vpc_subnet,
                    "preemptible":preemptible,
                    "status":status,
                    "zone":zone,
                    "region":region,
                    "internal_ip": internal_ip,
                    "external_ip":external_ip}
        output.append(metadata)
    return output

# Execute the gcloud command to get a list of projects
# and load data in JSON format for further processing
def project():
    list_project = "gcloud projects list --format json"
    project_op = subprocess.check_output(shlex.split(list_project))
    project_op_json = json.loads(project_op)
    for project_row in project_op_json:
        project_name = project_row["name"]
        project_id = project_row["projectId"]
        output = instance_metadata(project_id,project_name)
        print(json.dumps(output, indent=2))

if __name__ == "__main__":
    project()

