
from elasticsearch import Elasticsearch
import getpass


def get_es_client():

    username = input("Elasticsearch username: ")
    password = getpass.getpass("Elasticsearch password: ")

    es = Elasticsearch(
        ["https://elk.bhnam-elk.com:9200"],
        http_auth=(username, password),
        ca_certs="/etc/elasticsearch/certs/ca/ca.crt"
    )

    return es

