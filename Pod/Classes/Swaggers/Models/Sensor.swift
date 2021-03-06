//
// Sensor.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class Sensor: JSONEncodable {
    /** ID is the system-generated identifier of an entity. ID is unique among the entities of the same entity type. */
    public var iotId: String?
    /** Self-Link is the absolute URL of an entity which is unique among all other entities. */
    public var iotSelfLink: String?
    /** The description of the Sensor entity. */
    public var description: String?
    /** The encoding type of the metadata property. Its value is one of the ValueCode enumeration (see Table 8-14 for the available ValueCode: application/pdf or  http://www.opengis.net/doc/IS/SensorML/2.0). */
    public var encodingType: String?
    /** The detailed description of the sensor or system. The content is open to accommodate changes to SensorML or to support other description languages. */
    public var metadata: String?
    /** The Observations of a Datastream are measured with the same Sensor. One Sensor MAY produce zero-to-many Observations in different Datastreams. */
    public var datastreams: [Datastream]?
    /** link to related entities */
    public var datastreamsiotNavigationLink: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["@iot.id"] = self.iotId
        nillableDictionary["@iot.selfLink"] = self.iotSelfLink
        nillableDictionary["description"] = self.description
        nillableDictionary["encodingType"] = self.encodingType
        nillableDictionary["metadata"] = self.metadata
        nillableDictionary["Datastreams"] = self.datastreams?.encodeToJSON()
        nillableDictionary["Datastreams@iot.navigationLink"] = self.datastreamsiotNavigationLink
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
