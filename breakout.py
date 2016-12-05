import py2neo as pn
import networkx as nx

# ngraph = nx.Graph()
ngraph = nx.read_gml("marvel_characters.gml")

def add_to_nx_graph(rec):

	ngraph.add_edge(rec.r.start_node.properties["name"],rec.r.end_node.properties["name"], \
		weight=rec.r.properties["w"])

pgraph = pn.Graph("http://neo4j:bangial@localhost:7474/db/data")

cypher_query ="""MATCH (n)-[r:APPEARED]-(m) RETURN r ORDER BY r.w DESC SKIP {o} LIMIT {l}"""

for i in range(0, pgraph.size, 1000):
	records = pgraph.cypher.execute(cypher_query, o=i,l=1000)
	for r in records:
		add_to_nx_graph(r)
		tail = pgraph.size - i
	
	final_records = pgraph.cypher.execute(cypher_query, o=i,l=tail)

	for r in final_records:
		add_to_nx_graph(r)