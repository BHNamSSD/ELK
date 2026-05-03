from connect_elk import get_es_client

es = get_es_client()


try:
    info = es.info()
    print("Connected:", info["cluster_name"])
except Exception as e:
    print("Connection failed:", e)



