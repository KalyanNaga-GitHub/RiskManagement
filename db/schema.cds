namespace riskmanagement;

using {
    managed,
    cuid,
    User,
    sap.common.CodeList
} from '@sap/cds/common';

entity Risks : cuid, managed {
    title                   : String(100);
    owner                   : String;
    prio                    : Association to one Priority;
    descr                   : String;
    miti                    : Association to one Mitigations;
    impact                  : Integer;
    bp                      : Association to BusinessPartners;
    virtual criticality     : Integer;
    virtual PrioCriticality : Integer;
}

entity Mitigations : cuid, managed {
    descr    : String;
    owner    : String;
    timeline : String;
    risks    : Association to many Risks
                   on risks.miti = $self;
}

entity Priority : CodeList {
    key code : String enum {
            high   = 'H';
            medium = 'M';
            low    = 'L';
        };
}

entity Entity1 {
    key ID : UUID;
}

// Using an external service from SAP S/4HANA Cloud
using {API_BUSINESS_PARTNER as external} from '../srv/external/API_BUSINESS_PARTNER.csn';

entity BusinessPartners as
    projection on external.A_BusinessPartner {
        key BusinessPartner,
            BusinessPartnerFullName as FullName,
    }
