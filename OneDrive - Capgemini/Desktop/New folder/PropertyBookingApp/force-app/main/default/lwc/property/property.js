import { LightningElement ,wire} from 'lwc';
import getProfile from '@salesforce/apex/Profile.getProfile'
import propertyRecords from '@salesforce/apex/PropertyClass.allProperties';
import property from '@salesforce/schema/Property__c'
import propertyhash from '@salesforce/schema/Property__c.Property__c'
import Name from '@salesforce/schema/Property__c.Name'
import Area from '@salesforce/schema/Property__c.Area__c'
import State from '@salesforce/schema/Property__c.State__c'
import District from '@salesforce/schema/Property__c.District__c'
import Type from '@salesforce/schema/Property__c.Type__c'
import Storey from '@salesforce/schema/Property__c.Storey__c'
import builtOn from '@salesforce/schema/Property__c.Built_On__c'


export default class Property extends LightningElement {
  allProperties;
  opennewPropertForm
  objectApiName = property
  PropertyField=[propertyhash,Name,Area,State,District,Type,Storey,builtOn]
  
    @wire(propertyRecords)
        getRecords({data,error}){
            if(data){
                this.allProperties = data;
            }else{
                console.log(error);
            }
        }

        @wire(getProfile) 
        profile({data , error}){
        if(data){
            console.log(data)
        if(data == 'System Administrator' || data == 'Builder'){
            this.showButton = true;
          }else{
          this.showButton = false;
          }
        }
    }


        createnewProperty(){
          this.opennewPropertForm = true
        }

        hideForm(){
            this.opennewPropertForm =false
        }
        AddProperty(event){
            this.opennewPropertForm=false;
            window.location.reload();
        }

}