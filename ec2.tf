resource "aws_instance" "public_instance" {
#  count = length(var.instancias)
for_each = var.instancias
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name = data.aws_key_pair.key.key_name

tags  = {
#  "Name"  = var.instancias[count.index]  esto es para el ejemplo del count
   "Name"  = each.value
  
  } 

}

resource "aws_instance" "monitoring_instance" {
#count = var.enable_monitoring ==1 ? 1:0 esto es un ejemplo si la variable es numerica
count = var.enable_monitoring ? 1:0
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name = data.aws_key_pair.key.key_name

tags  = {
#  "Name"  = var.instancias[count.index]  esto es para el ejemplo del count
   "Name"  = "monitoreo"
  
  } 

}

variable "instancias" {
  description = "nombre de las instancias"
  type = set(string)
  default = [ "apache", "mysql", "jump" ]




}

