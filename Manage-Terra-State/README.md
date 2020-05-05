**How to manage Terraform State**
- what is Terra state?
- - custome json format which maps between Terra resource in configuration  file to the representation of those resources in reaal world.
- - It changes everytime you run terraform apply. so never edit this  file.
- - You can use terraform as a team on a real production project:
- - - It allows you to Shar storage for state files
- - - You can lock state file
- - - It is best prectice to isolate different envirounment statefiles. i.e testing, staging, production etc.

## This is for runnign two services
