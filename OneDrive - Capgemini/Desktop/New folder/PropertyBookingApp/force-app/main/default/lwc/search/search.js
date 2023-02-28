import { LightningElement , api } from 'lwc';
//import searchusingPropertyName from '@salesforce/apex/SearchClass.searchUsingPropertyName';
import searchusingPropertyName from '@salesforce/apex/SearchClass.searchUsingPropertyName';
import searchUsingPropertyId from '@salesforce/apex/SearchClass.searchUsingPropertyId';
import searchUsingBookingRef from '@salesforce/apex/SearchClass.searchUsingBookingRef';
import searchUsingCustomerName from '@salesforce/apex/SearchClass.searchUsingCustomerName';
import searchUsingQuoteNo from '@salesforce/apex/SearchClass.searchUsingQuoteNo';

export default class Search extends LightningElement {

   
    // values to show template
    ShowProperties
    ShowNoProprties
    ShowPropertyBooking
    ShowNoPropertyBooking
    ShowQuotation
    ShowNoQuotation
    ShowCustomer
    ShowNoCustomer

    //values after searching
    PropertyRecords
    QuotationRecords
    PropertyBookingRecords
    CustomerRecords
   
    //to get the value
    propertyName
    propertyId
    CustomerName
    BookingRef
    QuoteNo



  //function to assign records values after searching the data

       assignData(data){
        
        if(data[0].length !=0){
            this.PropertyRecords = data[0];
            this.ShowProperties=true;
        }else{
            this.ShowNoProprties=true;

        }
        if(data[1].length != 0){
            this.QuotationRecords = data[1];
            this.ShowQuotation = true;
        }else{
            this.ShowNoQuotation=true;
        }
        if(data[2].length != 0){
            this.PropertyBookingRecords = data[2];
            this.ShowPropertyBooking = true;
        }else{
            this.ShowNoPropertyBooking=true;
        }
        if(data[3].length != 0){
            this.CustomerRecords = data[3];
            this.ShowCustomer=true;
        }else{
            this.ShowNoCustomer=true;
        }
       }

       //function to catch error

       catchError(){
        this.ShowNoCustomer=true
       this.ShowNoProprties=true
        this.ShowNoPropertyBooking=true
        this.ShowNoQuotation=true
       }


    //function to disable other fields when data is entered in one of the field
    disablingFunction(targetvalue){
        this.template.querySelectorAll('lightning-input').forEach(item=>{
            if(item.value =='' && item.disabled==false){  
                item.disabled=true;
            }else if(targetvalue.value==''){
                targetvalue.disabled=false;
                item.disabled=false;
            }
           
        })
    }

    //functions to get the fields values entered by the user

    getPropertyName(event){      
        this.propertyName = event.target.value;
        this.disablingFunction(event.target);
    }
    getPropertyId(event){
        this.propertyId = event.target.value;
        this.disablingFunction(event.target)     
    }
    getCustomerName(event){
       this.CustomerName = event.target.value
       this.disablingFunction(event.target)
    }
    getBookingref(event){
        this.BookingRef = event.target.value
        this.disablingFunction(event.target)
    }
    getQuoteNo(event){  
        this.QuoteNo = event.target.value
        this.disablingFunction(event.target)
        event.target.disabled=false
    }

    //function to search the date based on the specified field

    search(){
        if(this.propertyName != undefined && this.propertyId==undefined && this.BookingRef==undefined && this.CustomerName==undefined && this.QuoteNo==undefined){
            searchusingPropertyName({propertyName : this.propertyName}).then(data=>{
               this.assignData(data);

            }).catch(error=>{
                this.catchError();
                console.log(error);
            })
        }else if(this.propertyName == undefined && this.propertyId!=undefined && this.BookingRef==undefined && this.CustomerName==undefined && this.QuoteNo==undefined){        
            searchUsingPropertyId({propertyId : this.propertyId}).then(data=>{
                this.assignData(data);
            }).catch(error=>{
                this.catchError();
                console.log(error);
            })


        }else if(this.propertyName == undefined && this.propertyId==undefined && this.BookingRef!=undefined && this.CustomerName==undefined && this.QuoteNo==undefined){            
              searchUsingBookingRef({BookingRef : this.BookingRef}).then(data=>{
                
                this.assignData(data)  
              }).catch(error=>{
                this.catchError();         
              })
               
        }else if(this.propertyName == undefined && this.propertyId==undefined && this.BookingRef==undefined && this.CustomerName!=undefined && this.QuoteNo==undefined){
              searchUsingCustomerName({customerName : this.CustomerName}).then(data=>{
                console.log(data)
                this.assignData(data);

              }).catch(error=>{
                this.catchError();
              })


        }else if(this.propertyName == undefined && this.propertyId==undefined && this.BookingRef==undefined && this.CustomerName==undefined && this.QuoteNo!=undefined){
            searchUsingQuoteNo({QuoteNo : this.QuoteNo}).then(data=>{
                this.assignData(data);
            }).catch(error=>{
                this.catchError();
            })

        }
    }

}