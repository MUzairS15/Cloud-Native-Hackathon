import { Chart } from "react-google-charts";

const Responses = function (props) {
    const {stat, responses} = props.props;
   
    if (stat.length > 0) {
        let obj = {
            rec: []
        };
        obj.rec.push(['Question', 'correct'])
        console.log("<>", stat)
        console.log("dasdsads", stat[0])
        obj.rec.push([`correct`, stat[0]])
        obj.rec.push([`wrong`, stat[1]])
        return (
            <>
                <div className="card mx-3 my-1 " style={{ width: "max-content" }} >
                    <div className="card-body flex-wrap" style={{ width: "18rem" }}>
                        <p style={{ textAlign: "start" }}>{stat.length} students answered correctly</p>
                    </div>
                </div>
                <div style={{ position: "relative" }}>
                    <Chart
                        width={'500px'}
                        height={'300px'}
                        chartType="PieChart"
                        loader={<div>Loading Chart</div>}
                        data={obj.rec}
                        options={{
                            title: 'Statistics',
                        }}
                        rootProps={{ 'data-testid': '1' }}
                    />
                </div>
            </>
        )
    } else {
        return <> </>
    }
}

export default Responses;