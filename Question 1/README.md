# Question 1: AWS AMI Information

This Python script lists information about AMIs in a given region and outputs the results to STDOUT. By default the script will use the `default` profile to query `us-east-1`, these can be changed by passing the `--profile` and `--region` flags to the script with your desired profile and region.

## Installation

Three dependencies are used for this script which need to be installed first. You can install these with pip `pip install -r requirements.txt`.

## Usage

```bash
# Default execution
python ./fortis
# Profile and region arguments
python3 fortis.py --profile development --region ap-southeast-1
```

## Example Output

To demonstrate the functionality of this script I deployed six instances with three different operating systems and ran the script without overriding the default profile and region.

Below is the output generated from my account.

```json
oliver@air /Users/oliver/git/fortis/Question 1> python3 fortis.py
[
  {
    "image_id": "ami-058bd2d568351da34",
    "image_name": "debian-12-amd64-20231013-1532",
    "image_description": "Debian 12 (20231013-1532)",
    "image_location": "amazon/debian-12-amd64-20231013-1532",
    "image_owner_id": "136693071363",
    "image_owner_alias": "amazon",
    "instances": [
      "i-08d150aaa6f080eef",
      "i-0e588ca3132f36ac8",
      "i-02f80c974d30df694"
    ],
    "instance_count": 3
  },
  {
    "image_id": "ami-0f403e3180720dd7e",
    "image_name": "al2023-ami-2023.3.20240304.0-kernel-6.1-x86_64",
    "image_description": "Amazon Linux 2023 AMI 2023.3.20240304.0 x86_64 HVM kernel-6.1",
    "image_location": "amazon/al2023-ami-2023.3.20240304.0-kernel-6.1-x86_64",
    "image_owner_id": "137112412989",
    "image_owner_alias": "amazon",
    "instances": [
      "i-0300fbdf743c13dac"
    ],
    "instance_count": 1
  },
  {
    "image_id": "ami-07d9b9ddc6cd8dd30",
    "image_name": "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240207.1",
    "image_description": "Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2024-02-07",
    "image_location": "amazon/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240207.1",
    "image_owner_id": "099720109477",
    "image_owner_alias": "amazon",
    "instances": [
      "i-09b38abf71279cc1c",
      "i-054c7808dcd07d895"
    ],
    "instance_count": 2
  }
]
```
