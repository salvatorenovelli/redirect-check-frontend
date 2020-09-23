import React from 'react';
import FileUploader from './FileUploader'
import Tasks from './Tasks'
import {Container, Row} from "reactstrap";


export default () =>
    <div className="App">
        <div className="App-header">
            <h2>Redirect check</h2>
            <div className={"logo"}>
                <img width={"120px"} alt="logo" src={"/img/logo_nobg.png"}/>
            </div>

            <Container>
                <Row>

                </Row>
            </Container>

        </div>
        <div className="container">
            <FileUploader/>
            <Tasks/>
        </div>
    </div>



