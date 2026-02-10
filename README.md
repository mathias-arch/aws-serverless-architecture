# Arquitectura Serverless con AWS & Terraform
![Terraform](https://img.shields.io/badge/Terraform-1.5.0+-9b51e0) ![AWS](https://img.shields.io/badge/AWS-Architecture-ff9900) ![Python](https://img.shields.io/badge/Python-Lambda-3776ab) ![DynamoDB](https://img.shields.io/badge/AWS-DynamoDB-4053d6) ![License](https://img.shields.io/badge/License-MIT-yellow)

---

## Descripción del Proyecto

Este proyecto representa el despliegue de una arquitectura backend profesional en **Amazon Web Services (AWS)** utilizando un enfoque moderno de **DevOps**. Se ha priorizado la automatización de la infraestructura, la seguridad mediante roles de IAM y la persistencia de datos en una base de datos NoSQL.

Todo el ecosistema ha sido orquestado mediante **Terraform**, permitiendo un despliegue repetible, escalable y eficiente en costes.
## Componentes de la Arquitectura

El sistema está diseñado para ser escalable, seguro y de bajo coste, utilizando los siguientes servicios:

* **API Gateway:** Expone un endpoint HTTP público para interactuar con el sistema.
* **AWS Lambda:** Lógica de backend procesada en **Python**, encargada de la gestión de peticiones y escritura en base de datos.
* **DynamoDB:** Base de datos NoSQL de alto rendimiento para el almacenamiento persistente de registros.
* **IAM Roles:** Configuración estricta de permisos bajo el principio de "mínimo privilegio" para la ejecución segura de la Lambda.

## Tecnologías Utilizadas

* **Lenguajes:** Python (Backend).
* **IaC:** Terraform (HCL).
* **Cloud:** AWS (Región eu-west-1).
* **Control de Versiones:** Git & GitHub.

## Seguridad y Mejores Prácticas

* **Gestión de Estado:** Uso de archivos `.tfstate` para el control de la infraestructura.
* **Protección de Datos:** Implementación de un archivo `.gitignore` robusto para evitar la exposición de binarios de Terraform y estados sensibles en repositorios públicos.
* **Automatización:** Ciclo completo de despliegue mediante `terraform apply` y limpieza total con `terraform destroy`.

## Próximos Pasos
Este repositorio sirve como base para el desarrollo de microservicios. La siguiente fase incluirá la implementación de un **Rastreador de Criptomonedas** (Bitcoin) automatizado mediante tareas programadas con **AWS EventBridge**.

##  Licencia

Este proyecto está bajo la **Licencia MIT**. Puedes consultar los términos legales en el siguiente enlace:

[Consultar Licencia MIT del Proyecto](./LICENSE)
