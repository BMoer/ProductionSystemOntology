[QueryGroup="Basic Queries"] @collection [[
[QueryItem="Sensors"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?sensor
WHERE
{
  ?sensor a sosa:Sensor .
}

[QueryItem="TemperatureSensor"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?sensor
WHERE
{
  ?sensor a :TemperatureSensor .
}

[QueryItem="Experiments"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?experiment ?name
WHERE
{
  	?experiment a :ManufacturingExperiment .
	?experiment rdfs:label ?name .

}

[QueryItem="Boreholes"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?borehole ?holenumber ?row ?column
WHERE
{
  	?borehole 	a :Borehole ;
			:holenumber ?holenumber ;
			:positionRow ?row ;
			:positionColumn ?column .

}

[QueryItem="Tools"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?toolname ?vendor ?diameter
WHERE
{
  	?tool 	a :Tool ;
		:vendor ?vendor;
		rdfs:label ?toolname;
		:diameter ?diameter .
}

[QueryItem="Plates"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?plate ?y ?z
WHERE
{
  	?plate 	a :Plate .
}
]]

[QueryGroup="FancyStuff"] @collection [[
[QueryItem="BoreholeWithCoatedTool"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>

SELECT ?holenumber ?row ?column ?toolname ?plate
WHERE
{
  	?borehole 	a :Borehole ;
			:holenumber ?holenumber ;
			:positionRow ?row ;
			:positionColumn ?column ;
			:isFeatureOf ?plate .
	?process		:createsFeature ?borehole .
	?process		:usesTool ?tool .
	?tool		a :CoatedDrill;
			rdfs:label ?toolname .

}

[QueryItem="ForceSignalsForParticularPhase"]
PREFIX : <http://ontologies.ift.at/production_systems.ttl/0.4#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ssn: <https://www.w3.org/ns/ssn/>
PREFIX sosa: <http://www.w3.org/ns/sosa/>
PREFIX time: <http://www.w3.org/2006/time#>

SELECT ?sensorname ?datatable ?start ?stop
WHERE
{
  	?sensor	a :ForceSensor ;
		:datatable ?datatable ;
		rdfs:label ?sensorname .
	?rig sosa:hosts ?sensor.
	?rig :executesProcess ?process .
	?process :hasPhase ?phase .
	?phase :cuttingSpeed ?cuttingSpeed;
		time:hasBeginning ?start;
		time:hasEnd ?stop.
	FILTER (?cuttingSpeed >= 100)
}
]]
