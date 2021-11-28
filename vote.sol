 /* SPDX-License-Identifier: MIT */
pragma solidity>=0.6.0;
contract evotesystem
 {
    address[] public voting;
   
        function strtvote(string[][] memory candidate_name,string[][] memory party_name,string[] memory position,uint hr) public
        {
           for(uint i=0;i<position.length;i++)
           {
               list newlist=new list(candidate_name[i],party_name[i],position[i],msg.sender,hr);
               voting.push(address(newlist));
            
           }  
        }
    function getsvotes() public view returns(address[] memory){
        return voting;
    }

    }
    contract list
    {
        struct candidate
        {
            string name;
            string party;
            uint votes_no;
            uint vote_time;
            uint end_time;

        }
        candidate[] public candidate_name;
        address public incharge;
        string public pos;
        mapping (address => bool) public vte;
        modifier restricted()
        {
            require(msg.sender==incharge);
            _;
        }
     constructor (string[] memory name,string[] memory cParty,string memory position,address creator,uint amtofhr ) 
     {
         incharge=creator;
         pos=position;
         for(uint i=0;i<name.length;i++)
        {
            candidate_name.push(candidate(
              {

               name:name[i],
                party:cParty[i],
                votes_no:0,
                vote_time: block.timestamp,
                end_time:block.timestamp + amtofhr
  }));
        }
     }
        function vote(uint index) public
    {
    require(! vte[msg.sender]);
  
    candidate_name[index].votes_no+=1;
    vte[msg.sender] = true;
    }

function getCandidatename(uint index) public restricted view returns (string memory)
{
    require(block.timestamp > candidate_name[index].end_time);
    return candidate_name[index].name;
}
function getParty(uint index) public restricted view returns (string memory) 
{
    require(block.timestamp >candidate_name[index].end_time);
    return candidate_name[index].party;
}

function getVoteCount(uint index)
public restricted view
returns(uint)
{

    return candidate_name[index].votes_no;
}

}
     
    