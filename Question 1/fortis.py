"""
  Name:   Question 1: AWS AMI Information
  Author: Oliver Collins
"""

import click
import boto3
import jsonpickle


class Image:

  def __init__(self, image_id):
    self.image_id = image_id
    self.image_name = "Null"
    self.image_description = "Null"
    self.image_location = "Null"
    self.image_owner_id = "Null"
    self.image_owner_alias = "Null"
    self.instances = []
    self.instance_count = 0

  def associate_instance(self, instance):
    self.instances.append(instance.instance_id)

  def update_image_information(self, ec2):
    image = ec2.Image(self.image_id)
    self.image_name = image.name
    self.image_description = image.description
    self.image_location = image.image_location
    self.image_owner_id = image.owner_id
    self.image_owner_alias = image.image_owner_alias
    self.instance_count = len(self.instances)


class Instance:
  def __init__(self, instance_id, image_id):
    self.instance_id = instance_id
    self.image_id = image_id


@click.command()
@click.option('--profile', default='default', help='The AWS profile to use.')
@click.option('--region', default='us-east-1', help='The AWS region to query.')
def instances(profile, region):
  """Reports on the AMI usage in a region"""
  ec2 = boto3.Session(profile_name=profile).resource('ec2', region_name=region)
  instances, images, image_ids, image_json = [], [], [], []

  for instance in ec2.instances.all():
    instances.append(Instance(instance.instance_id, instance.image_id))
    image_ids.append(instance.image_id)

  for image_id in dict.fromkeys(image_ids): images.append(Image(image_id))

  for image in images:
    for instance in instances:
      if instance.image_id == image.image_id:
        image.associate_instance(instance)
    image.update_image_information(ec2)

  print(jsonpickle.encode(images, unpicklable=False, indent=2))


if __name__ == '__main__':
  instances()
