//
// Observation.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class Observation: JSONEncodable {

    public var Datastream: Datastream?
    /** Navigation-Link is the relative URL that retrives content of related entities. */
    public var Navigation-Link: String?
    /** Association-Link is the relative URL showing the related entities in other entity types. Only the Self-Links of related entities are returned when resolving Association-Links. */
    public var Association-Link: String?
    public var FeatureOfInterest: FeatureOfInterest?
    /** Self-Link is the absolute URL of an entity which is unique among all other entities. */
    public var Self-link: String?
    /** The time point/period of when the observation happens. */
    public var phenomenonTime: NSDate?
    /** ID is the system-generated identifier of an entity. ID is unique among the entities of the same entity type. */
    public var ID: String?
    /** The data type of the ResultValue. Service should by default set the ResultType as Measure unless users specify a different ResultType when creating an observation. */
    public var ResultType: String?
    /** The estimated value of an observedProperty from the observation. */
    public var ResultValue: String?
    public var Sensor: Sensor?
    

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["Datastream"] = self.Datastream?.encodeToJSON()
        nillableDictionary["Navigation-Link"] = self.Navigation-Link
        nillableDictionary["Association-Link"] = self.Association-Link
        nillableDictionary["FeatureOfInterest"] = self.FeatureOfInterest?.encodeToJSON()
        nillableDictionary["Self-link"] = self.Self-link
        nillableDictionary["phenomenonTime"] = self.phenomenonTime?.encodeToJSON()
        nillableDictionary["ID"] = self.ID
        nillableDictionary["ResultType"] = self.ResultType
        nillableDictionary["ResultValue"] = self.ResultValue
        nillableDictionary["Sensor"] = self.Sensor?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
