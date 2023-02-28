import { LightningElement ,wire } from 'lwc';
import getProfile from '@salesforce/apex/Profile.getProfile'
import approval from '@salesforce/apex/ApprovalClass.approvalInit'
import propertyBookingApi from '@salesforce/schema/Property_Booking__c'
import bookingRecs from '@salesforce/apex/PropertyBooking.bookingRecs';
import quotationApi from '@salesforce/schema/Quotation__c';
import quotation  from '@salesforce/apex/QuotationClass.getQuotation';
import propertName from '@salesforce/schema/Property_Booking__c.Property__c';
import customerName from '@salesforce/schema/Property_Booking__c.Customer__c';
import Status from '@salesforce/schema/Property_Booking__c.Status__c';
import ActualPrice from '@salesforce/schema/Property_Booking__c.Actual_Price__c';
import AcquirePropertyBy from '@salesforce/schema/Property_Booking__c.Acquire_Property_By__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';


const actions = [
    { label: 'View', name: 'view'},
    { label: 'Edit', name: 'edit' },
    { label: 'Delete', name: 'delete' }
 ];
const cols = [
    {label:'Property' ,fieldName:'propertyName' , type:'Id'},
    {label:'Customer' ,fieldName:'customerName' , type:'Id'},
    {label:'Status' ,fieldName:'Status__c' , type:'Picklist'},
    {label:'Actual Price' ,fieldName:'Actual_Price__c' , type:'Currency'},
    {label:'Quoted Price' ,fieldName:'Quoted_Price__c' , type:'Currency'},
    {label:'Quotation Gnerated' ,fieldName:'Quotation_Generated__c' , type:'Checkbox'},
    {label:'Booking Reference' ,fieldName:'Name' , type:'AutoNumber'},
    {label:'Acquire Property By' ,fieldName:'Acquire_Property_By__c' , type:'Date'},
    { label:"Action", type: "button", typeAttributes: {  
        label: 'Open Quote',  
        name: 'OpenQuote',  
        title: 'OpenQuote',  
        disabled: false,  
        value: 'OpenQuote',  
        iconPosition: 'left'  }},
        { label:"Action", type: "button", typeAttributes: {  
            label: 'Send For Approval',  
            name: 'SendForApproval',  
            title: 'SendForApproval',  
            disabled: {fieldName :'Quotation_Generated__c' },  
            value: 'SendForApproval',  
            iconPosition: 'left'  }},
        
    {type : 'action' , typeAttributes:{rowActions :actions ,menuAlignment: 'right'}}

]


export default class PropertyBooking extends LightningElement {
    columns = cols;
    data;
    propertyBookingobjectApiName = propertyBookingApi;
    PropertyBookingField=[propertName ,customerName,Status, ActualPrice,AcquirePropertyBy]
    propertyBookingrecId;
    objectApiName = quotationApi;
    viewForm;
    recId;
    NoQuotationForm;
    quotationData;
    opennewPropertyBookingForm
    showButton
    action
    viewrecordForm
    editForm
    deleteConfirm


    @wire(bookingRecs) 
        getData({data , error}){
           if(data){ 
            const tempData=[]; 
            data.forEach(d=>{
              
            let temp = {...d}
            temp.customerName = d.Customer__r.Name;
            temp.propertyName = d.Property__r.Name;
            tempData.push(temp);
            })
            this.data = tempData;
            
           } else{
            console.log(error);
           }
         
        }
    //function to get the current profile
        @wire(getProfile) 
        profile({data , error}){
        if(data){
            console.log(data)
        if(data == 'System Administrator'  || data == 'Contractor'){
            this.showButton = true;
          }else{
          this.showButton = false;
          }
        }
    }
   
  //function for all the buttons in the data table
        buttonaction(event){
        this.propertyBookingrecId = event.detail.row.Id;
        this.action = event.detail.action.name;
       
         if(this.action=='view'){ 
         this.viewrecordForm=true;
        }else if(this.action=='edit'){
            this.editForm=true;
        }else if(this.action=='delete'){
            this.deleteConfirm = true;
        }else if(this.action=='OpenQuote'){
        quotation({propertyId : this.propertyBookingrecId}).then(data=>{
            this.quotationData = data;
            console.log(this.quotationData)
            this.viewForm = true;
            
        }).catch(error=>{
          this.NoQuotationForm=true;
          this.viewForm=false;
            console.log(error);
        })
    }else if(this.action == 'SendForApproval'){
        approval({ id : this.propertyBookingrecId , comment : 'This record has been submitted for your approval.'}).then(data=>{
            const event = new ShowToastEvent({
                title: 'Success',
                message: ' Sent For Approval',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            window.location.reload();
        }).catch(error=>{
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Failed',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            window.location.reload();
        })


    }
        }

        //function to create a new property Booking
        createnewPropertyBooking(){
           this.opennewPropertyBookingForm = true

        }
        AddPropertyBooking(){
            this.opennewPropertyBookingForm=false
            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Record created Successfully',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            window.location.reload();
        }

        //function to update the property booking
        update(){
            this.editForm=false;
            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Record Updated Successfully',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            
            window.location.reload();
        }

        //function to delete the selected record
        deleterec(){
            deleteRecord(this.propertyBookingrecId).then(data=>{
                window.location.reload();
                const event = new ShowToastEvent({
                    title: 'Success',
                    message: 'Record Deleted',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);
        
                this.deleteConfirm=false;
                
                
            }).catch(error=>{
                console.log(error);
            })
        }


        hideForm(){
            this.viewForm = false;
            this.editForm=false
            this.NoQuotationForm=false;
            this.opennewPropertyBookingForm=false
            this.viewrecordForm=false;
        }
    
}