import json
import boto3
import uuid

# Conexión a mi base de datos en Irlanda
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('MathiasDataTable')

def lambda_handler(event, context):
    # Genero mi propio ID de transacción
    mi_id = str(uuid.uuid4())

    # Guardo mi registro en la tabla
    table.put_item(Item={
        'UserId': mi_id,
        'nombre': 'Mathias',
        'mensaje': 'Mi arquitectura serverless está funcionando'
    })

    # Mi página de éxito (en primera persona y sin caracteres especiales conflictivos)
    cuerpo_web = f"""
    <html>
        <head><meta charset="UTF-8"></head>
        <body style="text-align: center; font-family: Arial, sans-serif; padding-top: 100px;">
            <h1 style="color: #FF9900; font-size: 3rem;">¡Mi Proyecto Cloud está Vivo!</h1>
            <p style="font-size: 1.5rem; color: #333;">
                He desplegado esta infraestructura completa en <strong>AWS</strong> usando <strong>Terraform</strong>.
            </p>
            <div style="background: #fdfdfd; border: 2px solid #FF9900; display: inline-block; padding: 30px; border-radius: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                <h3 style="margin-top: 0;">Estado de mi Sistema:</h3>
                <p>✅ Mi base de datos DynamoDB ha recibido el registro.</p>
                <p style="color: #666;"><strong>Mi ID de proceso:</strong> {mi_id}</p>
            </div>
            <p style="margin-top: 40px; color: #888;">Python + Lambda + API Gateway + DynamoDB</p>
        </body>
    </html>
    """

    # La respuesta que mi API Gateway entiende perfectamente
    return {
        "isBase64Encoded": False,
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/html; charset=utf-8"
        },
        "body": cuerpo_web
    }
