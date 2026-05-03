from elasticsearch import Elasticsearch
import getpass

username = input("Elasticsearch username: ")
password = getpass.getpass("Elasticsearch password: ")

es = Elasticsearch(
    ["https://elk.bhnam-elk.com:9200"],
    http_auth=(username, password),
    ca_certs="/etc/elasticsearch/certs/ca/ca.crt" 
    
)

try:
    info = es.info()
    print("connetion OK")
    print(info)
except Exception as e:
    print("connetion Fail", e)
