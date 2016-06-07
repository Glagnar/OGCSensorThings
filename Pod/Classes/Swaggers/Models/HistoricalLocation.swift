//
// HistoricalLocation.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class HistoricalLocation: JSONEncodable {
    /** ID is the system-generated identifier of an entity. ID is unique among the entities of the same entity type. */
    public var iotId: String?
    /** Self-Link is the absolute URL of an entity which is unique among all other entities. */
    public var iotSelfLink: String?
    /** The time when the Thing is known at the Location. Datatype TM_Instant (ISO-8601 Time String) */
    public var time: String?
    /** A Location can have zero-to-many HistoricalLocations. One HistoricalLocation SHALL have one or many Locations. */
    public var locations: [Location]?
    /** A HistoricalLocation has one-and-only-one Thing. One Thing MAY have zero-to-many HistoricalLocations.  */
    public var thing: Thing?
    /** link to related entities */
    public var locationsiotNavigationLink: String?
    /** link to related entities */
    public var thingiotNavigationLink: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["@iot.id"] = self.iotId
        nillableDictionary["@iot.selfLink"] = self.iotSelfLink
        nillableDictionary["time"] = self.time
        nillableDictionary["Locations"] = self.locations?.encodeToJSON()
        nillableDictionary["Thing"] = self.thing?.encodeToJSON()
        nillableDictionary["Locations@iot.navigationLink"] = self.locationsiotNavigationLink
        nillableDictionary["Thing@iot.navigationLink"] = self.thingiotNavigationLink
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
