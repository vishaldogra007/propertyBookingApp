import { LightningElement,wire } from 'lwc';
import allQuotations from '@salesforce/apex/QuotationClass.getAllQuotation';
import sendEmail from '@salesforce/apex/Email.sendQuote';
import changeQuoteCheckbox from '@salesforce/apex/QuotationClass.quotedToCustomer';
import quotationApiName from '@salesforce/schema/Quotation__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


const actions = [
    { label: 'View', name: 'view'}
 ];
const cols = [
    {label:'Booking ref' , fieldName:'Booking_Ref__c' , type:'Id'} ,
    {label:'Property Name' , fieldName:'Name' , type:'text'} ,
    {label:'Property Type' , fieldName:'Property_Type__c' , type:'text'} ,
    {label:'Customer Name' , fieldName:'Customer_Name__c' , type:'text'} ,
    {label:'Acquire Property By' , fieldName:'Acquire_Property_By__c' , type:'date'} ,
    {label:'Price' , fieldName:'Price__c' , type:'currency'} ,
    {label:'Quoted To Customer' , fieldName:'Quoted_to_Customer__c' , type:'checkbox'} ,
    {label:'Customer Email' , fieldName:'Customer_Email__c' , type:'email'} ,
    {label:'Quote No' , fieldName:'Quote_No__c' , type:'Auto Number'} ,
    {label:'Actions'  , type:'button' , typeAttributes:{
        label: 'Send Quote',  
        name: 'SendQuote',  
        title: 'SendQuote',  
        disabled: {fieldName:'Quoted_to_Customer__c'},  
        value: 'SendQuote',  
        iconPosition: 'left'
    }},
    {type : 'action' , typeAttributes:{rowActions :actions ,menuAlignment: 'right'}} 
]

export default class Quotation extends LightningElement {
data;
columns = cols;
action
viewrecordForm
QuotationobjectApiName = quotationApiName
recId

ShowsuccessEvent(){
    const event = new ShowToastEvent({
        title: 'Mail Status',
        message: 'Qutotation Sent To Customer',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
}

@wire(allQuotations)
     allData({data,error}){
        if(data){
            this.data=data;
        }else{
            console.log(error);
        }
     }

     SendQuoteAction(event){
        this.recId = event.detail.row.Id;
        this.action = event.detail.action.name;
        if(this.action == 'SendQuote'){
            sendEmail({quoteId : event.detail.row.Id }).then(data=>{
                if(data=='Success'){
                    changeQuoteCheckbox({quoteId : event.detail.row.Id}).then(data=>{
                        this.ShowsuccessEvent();
                        window.location.reload();
                    }).catch(error=>{
                        console.log(error)
                    })
                }
            }).catch(error=>{
                console.log(error);
            })

        }else if(this.action=='view'){
            this.viewrecordForm = true;
        }
        
        


     }
     hideForm(){
        this.viewrecordForm = false;
     }

}