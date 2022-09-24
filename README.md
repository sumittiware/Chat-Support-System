# Branch-Intl Assignment

## Chat Support System

## Technologies used : Flutter web, Flutter(android), Firebase(database and realtime behavior of the system)

Chat Support System Dashboard [here](https://letstalk-4bd39.web.app)
Client android app [here](https://drive.google.com/file/d/14xVR2WcD3l--JMaodmXUVRyCG_hxu8Hi/view?usp=sharing)

The website is made with Flutter(frontend) & Firebase(for realtime behavior), important packages used :

    <br>1) Firebase Core & Firebase Firestore to handle firebase.
    <br>2) Providers to manage app wide state.
    <br>3) Flutter SVG to handle svg images.
    <br>4) RandomAvtar to provide random unique avatar to each user.

## System works as follows :

    <br>1) As soon as the client send messege from the android app the messege is avaliable in user dashboard in ALL and UNASSIGNED section.

    <br>2) Any logged in agent can pick up the avaliable UNASSIGNED chat and try to resolve the query.

    <br>3) Once the chat is picked by the agent, other agent cannot interven and the chat will be added to ACTIVE section and will be locked, only the client and assigned agent will chat.

    <br>4) To ensure that the chat not blocked forever, a time window of 15-minutes is allowed to after the last messege from agent.

    <br>5) If the agent does respond within the window the chat will be avaliable in IN-ACTIVE section of the website and new agent can continue with the query.

    <br>6) If the query is solved by the agent then agent can finish the chat and the chat will be avaliable in FINISHED section, no further converstions are allowed in such chats.


    Credentials for logging in to Agent-dashboard :

    usernames : Rohit, Samule, Martin.
    password : 12345 same for all.

)

The website is made with Flutter(frontend) & Firebase(for realtime behavior), important packages used :

    <br>1) Firebase Core & Firebase Firestore to handle firebase.
    <br>2) Providers to manage app wide state.
    <br>3) Flutter SVG to handle svg images.
    <br>4) RandomAvtar to provide random unique avatar to each user.

## System works as follows :

    <br>1) As soon as the client send messege from the android app the messege is avaliable in user dashboard in ALL and UNASSIGNED section.

    <br>2) Any logged in agent can pick up the avaliable UNASSIGNED chat and try to resolve the query.

    <br>3) Once the chat is picked by the agent, other agent cannot interven and the chat will be added to ACTIVE section and will be locked, only the client and assigned agent will chat.

    <br>4) To ensure that the chat not blocked forever, a time window of 15-minutes is allowed to after the last messege from agent.

    <br>5) If the agent does respond within the window the chat will be avaliable in IN-ACTIVE section of the website and new agent can continue with the query.

    <br>6) If the query is solved by the agent then agent can finish the chat and the chat will be avaliable in FINISHED section, no further converstions are allowed in such chats.


    Credentials for logging in to Agent-dashboard :

    usernames : Rohit, Samule, Martin.
    password : 12345 same for all.
