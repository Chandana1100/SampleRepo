trigger SampleTrigger on Opportunity (after update) {

WrapSample WS = new WrapSample();

for (Opportunity Oppty: Trigger.new) 
{
   Opportunity oldOpp = Trigger.oldMap.get(Oppty.ID);
      //if (Oppty.Stage = 'Closed Won') {
       //WS.EchoString(input);
   // }
}

}