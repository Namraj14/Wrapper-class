/**

* @ClassName      : GuestReviewProcessor
* @Description    : Agentforce Apex Action used to capture and process
* ```
                guest experience reviews submitted through chat.
  ```
*
* Functionality:
* 1. Receives Contact, Experience, Review, and Rating from Agentforce.
* 2. Creates Guest_Review__c records in Salesforce.
* 3. Returns a success or failure message back to the Agent.
* 4. Supports bulk processing by handling a list of requests.
     */
     public class GuestReviewProcessor {

  /**

  * Invocable method exposed to Agentforce as the
  * "Process Guest Reviews" action.
  *
  * Agent passes review details collected during the conversation.
  * The method creates Guest Review records and returns the result
  * back to the Agent through the response wrapper.
    */
    @InvocableMethod(
    label='Process Guest Reviews'
    description='Processes guest reviews submitted through Agentforce'
    )
    public static List<GuestReviewResponse> processReviews(List<GuestReviewRequest> requests){

    GuestReviewResponse response = new GuestReviewResponse();

    try{

    ```
     // Collection used to perform a single bulk DML operation.
     List<Guest_Review__c> reviewsToInsert = new List<Guest_Review__c>();

     for(GuestReviewRequest req : requests){

         // Map Agentforce inputs to Guest Review record fields.
         Guest_Review__c reviewRecord = new Guest_Review__c(
             Contact__c = req.contact.Id,
             Experience__c = req.experience.Id,
             Comments__c = req.review,
             Rating__c = req.rating
         );

         reviewsToInsert.add(reviewRecord);
     }

     // Insert all reviews in one DML statement.
     insert reviewsToInsert;

     response.message = 'Review processed successfully.';
    ```

    }
    catch(Exception e){

    ```
     // Return a user-friendly message instead of exposing
     // internal exception details to the customer.
     response.message = 'There was a problem processing the review.';
    ```

    }

    return new List<GuestReviewResponse>{ response };
    }

  /**

  * Input wrapper class.
  * Defines the variables Agentforce must provide when invoking
  * the Process Guest Reviews action.
    */
    public class GuestReviewRequest {

    @InvocableVariable(
    required=true
    label='Contact'
    description='Contact submitting the review'
    )
    public Contact contact;

    @InvocableVariable(
    required=true
    label='Experience'
    description='Experience being reviewed'
    )
    public Experience__c experience;

    @InvocableVariable(
    required=true
    label='Review'
    description='Guest review comments'
    )
    public String review;

    @InvocableVariable(
    required=true
    label='Rating'
    description='Guest rating'
    )
    public String rating;
    }

  /**

  * Output wrapper class.
  * Returns processing status back to Agentforce after
  * review creation is completed.
    */
    public class GuestReviewResponse {

    @InvocableVariable(
    label='status'
    description='Review processing status'
    )
    public String message;
    }
    }
