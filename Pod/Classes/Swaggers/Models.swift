// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> AnyObject
}

public class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T

    public init(statusCode: Int, header: [String: String], body: T) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: NSHTTPURLResponse, body: T) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = dispatch_once_t()
class Decoders {
    static private var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz clazz: T.Type, decoder: ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as! AnyObject }
    }

    static func decode<T>(clazz clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.intValue as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.longLongValue as! T;
        }
        if T.self is String.Type && source is NSNumber {
            return source.stringValue as! T;
        }
        if source is T {
            return source as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static private func initialize() {
        dispatch_once(&once) {
            let formatters = [
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss'Z'",
                "yyyy-MM-dd'T'HH:mm:ss.SSS"
            ].map { (format: String) -> NSDateFormatter in
                let formatter = NSDateFormatter()
                formatter.dateFormat = format
                return formatter
            }
            // Decoder for NSDate
            Decoders.addDecoder(clazz: NSDate.self) { (source: AnyObject) -> NSDate in
               if let sourceString = source as? String {
                    for formatter in formatters {
                        if let date = formatter.dateFromString(sourceString) {
                            return date
                        }
                    }

                }
                if let sourceInt = source as? Int {
                    // treat as a java date
                    return NSDate(timeIntervalSince1970: Double(sourceInt / 1000) )
                }
                fatalError("formatter failed to parse \(source)")
            } 

            // Decoder for [Datastream]
            Decoders.addDecoder(clazz: [Datastream].self) { (source: AnyObject) -> [Datastream] in
                return Decoders.decode(clazz: [Datastream].self, source: source)
            }
            // Decoder for Datastream
            Decoders.addDecoder(clazz: Datastream.self) { (source: AnyObject) -> Datastream in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Datastream()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.unitOfMeasure = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["unitOfMeasure"])
                instance.observationType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["observationType"])
                instance.observedArea = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["observedArea"])
                instance.phenomenonTime = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["phenomenonTime"])
                instance.resultTime = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["resultTime"])
                instance.thing = Decoders.decodeOptional(clazz: Thing.self, source: sourceDictionary["Thing"])
                instance.sensor = Decoders.decodeOptional(clazz: Sensor.self, source: sourceDictionary["Sensor"])
                instance.observedProperty = Decoders.decodeOptional(clazz: ObservedProperty.self, source: sourceDictionary["ObservedProperty"])
                instance.observations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Observations"])
                instance.thingiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Thing@iot.navigationLink"])
                instance.sensoriotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Sensor@iot.navigationLink"])
                instance.observedPropertyiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["ObservedProperty@iot.navigationLink"])
                instance.observationsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Observations@iot.navigationLink"])
                return instance
            }


            // Decoder for [DatastreamsResponse]
            Decoders.addDecoder(clazz: [DatastreamsResponse].self) { (source: AnyObject) -> [DatastreamsResponse] in
                return Decoders.decode(clazz: [DatastreamsResponse].self, source: source)
            }
            // Decoder for DatastreamsResponse
            Decoders.addDecoder(clazz: DatastreamsResponse.self) { (source: AnyObject) -> DatastreamsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = DatastreamsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [FeatureOfInterest]
            Decoders.addDecoder(clazz: [FeatureOfInterest].self) { (source: AnyObject) -> [FeatureOfInterest] in
                return Decoders.decode(clazz: [FeatureOfInterest].self, source: source)
            }
            // Decoder for FeatureOfInterest
            Decoders.addDecoder(clazz: FeatureOfInterest.self) { (source: AnyObject) -> FeatureOfInterest in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = FeatureOfInterest()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.encodingType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["encodingType"])
                instance.feature = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["feature"])
                instance.observations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Observations"])
                instance.observationsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Observations@iot.navigationLink"])
                return instance
            }


            // Decoder for [FeatureOfInterestsResponse]
            Decoders.addDecoder(clazz: [FeatureOfInterestsResponse].self) { (source: AnyObject) -> [FeatureOfInterestsResponse] in
                return Decoders.decode(clazz: [FeatureOfInterestsResponse].self, source: source)
            }
            // Decoder for FeatureOfInterestsResponse
            Decoders.addDecoder(clazz: FeatureOfInterestsResponse.self) { (source: AnyObject) -> FeatureOfInterestsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = FeatureOfInterestsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [HistoricalLocation]
            Decoders.addDecoder(clazz: [HistoricalLocation].self) { (source: AnyObject) -> [HistoricalLocation] in
                return Decoders.decode(clazz: [HistoricalLocation].self, source: source)
            }
            // Decoder for HistoricalLocation
            Decoders.addDecoder(clazz: HistoricalLocation.self) { (source: AnyObject) -> HistoricalLocation in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = HistoricalLocation()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.time = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["time"])
                instance.locations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Locations"])
                instance.thing = Decoders.decodeOptional(clazz: Thing.self, source: sourceDictionary["Thing"])
                instance.locationsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Locations@iot.navigationLink"])
                instance.thingiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Thing@iot.navigationLink"])
                return instance
            }


            // Decoder for [HistoricalLocationsResponse]
            Decoders.addDecoder(clazz: [HistoricalLocationsResponse].self) { (source: AnyObject) -> [HistoricalLocationsResponse] in
                return Decoders.decode(clazz: [HistoricalLocationsResponse].self, source: source)
            }
            // Decoder for HistoricalLocationsResponse
            Decoders.addDecoder(clazz: HistoricalLocationsResponse.self) { (source: AnyObject) -> HistoricalLocationsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = HistoricalLocationsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [Location]
            Decoders.addDecoder(clazz: [Location].self) { (source: AnyObject) -> [Location] in
                return Decoders.decode(clazz: [Location].self, source: source)
            }
            // Decoder for Location
            Decoders.addDecoder(clazz: Location.self) { (source: AnyObject) -> Location in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Location()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.encodingType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["encodingType"])
                instance.location = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["location"])
                instance.things = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Things"])
                instance.historicalLocations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["HistoricalLocations"])
                instance.thingsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Things@iot.navigationLink"])
                instance.historicalLocationsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["HistoricalLocations@iot.navigationLink"])
                return instance
            }


            // Decoder for [LocationsResponse]
            Decoders.addDecoder(clazz: [LocationsResponse].self) { (source: AnyObject) -> [LocationsResponse] in
                return Decoders.decode(clazz: [LocationsResponse].self, source: source)
            }
            // Decoder for LocationsResponse
            Decoders.addDecoder(clazz: LocationsResponse.self) { (source: AnyObject) -> LocationsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LocationsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [Observation]
            Decoders.addDecoder(clazz: [Observation].self) { (source: AnyObject) -> [Observation] in
                return Decoders.decode(clazz: [Observation].self, source: source)
            }
            // Decoder for Observation
            Decoders.addDecoder(clazz: Observation.self) { (source: AnyObject) -> Observation in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Observation()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.phenomenonTime = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["phenomenonTime"])
                instance.result = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["result"])
                instance.resultTime = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["resultTime"])
                instance.resultQuality = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["resultQuality"])
                instance.validTime = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["validTime"])
                instance.parameters = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["parameters"])
                instance.datastream = Decoders.decodeOptional(clazz: Datastream.self, source: sourceDictionary["Datastream"])
                instance.featureOfInterest = Decoders.decodeOptional(clazz: FeatureOfInterest.self, source: sourceDictionary["FeatureOfInterest"])
                instance.datastreamiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Datastream@iot.navigationLink"])
                instance.featureOfInterestiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["FeatureOfInterest@iot.navigationLink"])
                return instance
            }


            // Decoder for [ObservationsResponse]
            Decoders.addDecoder(clazz: [ObservationsResponse].self) { (source: AnyObject) -> [ObservationsResponse] in
                return Decoders.decode(clazz: [ObservationsResponse].self, source: source)
            }
            // Decoder for ObservationsResponse
            Decoders.addDecoder(clazz: ObservationsResponse.self) { (source: AnyObject) -> ObservationsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ObservationsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [ObservedPropertiesResponse]
            Decoders.addDecoder(clazz: [ObservedPropertiesResponse].self) { (source: AnyObject) -> [ObservedPropertiesResponse] in
                return Decoders.decode(clazz: [ObservedPropertiesResponse].self, source: source)
            }
            // Decoder for ObservedPropertiesResponse
            Decoders.addDecoder(clazz: ObservedPropertiesResponse.self) { (source: AnyObject) -> ObservedPropertiesResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ObservedPropertiesResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [ObservedProperty]
            Decoders.addDecoder(clazz: [ObservedProperty].self) { (source: AnyObject) -> [ObservedProperty] in
                return Decoders.decode(clazz: [ObservedProperty].self, source: source)
            }
            // Decoder for ObservedProperty
            Decoders.addDecoder(clazz: ObservedProperty.self) { (source: AnyObject) -> ObservedProperty in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ObservedProperty()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.name = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["name"])
                instance.definition = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["definition"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.datastreams = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Datastreams"])
                instance.datastreamsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Datastreams@iot.navigationLink"])
                return instance
            }


            // Decoder for [Sensor]
            Decoders.addDecoder(clazz: [Sensor].self) { (source: AnyObject) -> [Sensor] in
                return Decoders.decode(clazz: [Sensor].self, source: source)
            }
            // Decoder for Sensor
            Decoders.addDecoder(clazz: Sensor.self) { (source: AnyObject) -> Sensor in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Sensor()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.encodingType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["encodingType"])
                instance.metadata = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["metadata"])
                instance.datastreams = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Datastreams"])
                instance.datastreamsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Datastreams@iot.navigationLink"])
                return instance
            }


            // Decoder for [SensorsResponse]
            Decoders.addDecoder(clazz: [SensorsResponse].self) { (source: AnyObject) -> [SensorsResponse] in
                return Decoders.decode(clazz: [SensorsResponse].self, source: source)
            }
            // Decoder for SensorsResponse
            Decoders.addDecoder(clazz: SensorsResponse.self) { (source: AnyObject) -> SensorsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = SensorsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }


            // Decoder for [Thing]
            Decoders.addDecoder(clazz: [Thing].self) { (source: AnyObject) -> [Thing] in
                return Decoders.decode(clazz: [Thing].self, source: source)
            }
            // Decoder for Thing
            Decoders.addDecoder(clazz: Thing.self) { (source: AnyObject) -> Thing in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Thing()
                instance.iotId = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.id"])
                instance.iotSelfLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.selfLink"])
                instance.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"])
                instance.properties = Decoders.decodeOptional(clazz: AnyObject.self, source: sourceDictionary["properties"])
                instance.locations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Locations"])
                instance.historicalLocations = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["HistoricalLocations"])
                instance.datastreams = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["Datastreams"])
                instance.historicalLocationsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["HistoricalLocations@iot.navigationLink"])
                instance.datastreamsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Datastreams@iot.navigationLink"])
                instance.locationsiotNavigationLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["Locations@iot.navigationLink"])
                return instance
            }


            // Decoder for [ThingsResponse]
            Decoders.addDecoder(clazz: [ThingsResponse].self) { (source: AnyObject) -> [ThingsResponse] in
                return Decoders.decode(clazz: [ThingsResponse].self, source: source)
            }
            // Decoder for ThingsResponse
            Decoders.addDecoder(clazz: ThingsResponse.self) { (source: AnyObject) -> ThingsResponse in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ThingsResponse()
                instance.iotCount = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["@iot.count"])
                instance.value = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["value"])
                instance.iotNextLink = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["@iot.nextLink"])
                return instance
            }
        }
    }
}
