trigger AssignUsers on Student__c (before insert,before update)
{
    set<String> picklistvalue = new Set<String>();
    List<String> splitString = new List<String>();
    for(Student__c s : Trigger.New)
    {
        if(s.Business_Owner__c.contains(';'))
            splitString = s.Business_Owner__c.split(';');
        else
            picklistvalue.add(s.Business_Owner__c);
    }
    
    for(String ss : splitString)
    {
        picklistvalue.add(ss);
    }
    
    List<Group> glist = [select Id from Group where Name =: picklistvalue and Type = 'Queue'];
    Map<String,Id> QueuememberId = new Map<String,Id>();
    set<Id> group_Id = new Set<Id>();
    for(Group g : glist)
    {
        group_Id.add(g.id);
    }
    
    List<GroupMember> gmlist = [select Group.Name,UserOrGroupId from GroupMember where GroupId =:group_Id];
    for(GroupMember gm : gmlist)
    {
        QueuememberId.put(gm.group.name,gm.UserOrGroupId);
    }
    
    for(Student__c s : Trigger.New)
    {        
        s.User_Lookup_Field1__c = QueuememberId.get('School');
        s.User_Lookup_Field2__c = QueuememberId.get('Professional');
    }
}