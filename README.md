# Fern1InfraAsCode
VIRTP - Fernlehre 1 // Infrastructure-as-Code / AWS

Infrastructure-as-Code Übung - in den 2er Gruppen
Angelehnt an die Übung https://fhb-codelabs.github.io/codelabs/virt-pt-terraform-ec2-cloudinit/index.html, soll eine Applikation mittels Infrastructure-as-Code/Terraform installiert werden.

Constraints

Die Applikation soll aus mindestens 3 Microservices bzw. VMs bestehen, welche miteinander kommunizieren. Sofern euch bereits elegantere Möglichkeiten bekannt sind, dieses zu bewerkstelligen, könnt ihr eurer Kreativität gerne freien Lauf lassen.
Die Installation erfolgt ausschließlich code-basiert mittels Terraform (sofern sich jemand mit Crossplane/Pulumi befassen möchte, ist dies natürlich auch kein Problem)
Jede Gruppe verwendet eine andere Applikation
Getroffene Annahmen über die Infrastruktur sind dokumentiert
Es ist ohne weiteres möglich, dieses Setup zu reproduzieren
Notwendige Troubleshooting-Maßnahmen meinerseits führen zu erheblichen Punkteabzug 

Deliverable

Der Infrastructure-Code ist in einem GitHub Repository bereitzustellen (mein GitHub Username ist @thschue). Bitte gebt in diesen Zusammenhang auf die Trennung Code/Konfiguration sowie auf Secrets acht, im Klartext eingecheckte Secrets im führen ebenfalls zu Punkteabzug. 

QuickSetup:

git clone https://github.com/phil-fh/Fern1InfraAsCode  
Start aws Learner Lab and update ~/.aws/credentials  
cd ../Fern1InfraAsCode  
terraform init  
terraform plan  
terraform apply  
