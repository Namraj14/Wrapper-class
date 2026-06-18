public class WorkspaceWrapper {

    public Workspace__c workspace;

    public String buildingName;

    public String floorName;

    public Integer availableSeats;
}

WorkspaceWrapper wrapper =
    new WorkspaceWrapper();

wrapper.workspace = new Workspace__c(
    Name = 'WS-101'
);

wrapper.buildingName = 'Tower A';
wrapper.floorName = '5th Floor';
wrapper.availableSeats = 12;

System.debug(wrapper.workspace.Name);
System.debug(wrapper.buildingName);
System.debug(wrapper.floorName);
System.debug(wrapper.availableSeats);
