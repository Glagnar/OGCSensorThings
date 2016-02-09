//
// Sensor.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class Sensor: JSONEncodable {

    /** The detailed description of the sensor or system. The content is open to accommodate changes to SensorML or to support other description languages. */
    public var Metadata: String?
    /** Self-Link is the absolute URL of an entity which is unique among all other entities. */
    public var Self-link: String?
    /** Navigation-Link is the relative URL that retrives content of related entities. */
    public var Navigation-Link: String?
    /** Association-Link is the relative URL showing the related entities in other entity types. Only the Self-Links of related entities are returned when resolving Association-Links. */
    public var Association-Link: String?
    /** ID is the system-generated identifier of an entity. ID is unique among the entities of the same entity type. */
    public var ID: String?
    public var Observations: [Observation]?
    

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["Metadata"] = self.Metadata
        nillableDictionary["Self-link"] = self.Self-link
        nillableDictionary["Navigation-Link"] = self.Navigation-Link
        nillableDictionary["Association-Link"] = self.Association-Link
        nillableDictionary["ID"] = self.ID
        nillableDictionary["Observations"] = self.Observations?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
