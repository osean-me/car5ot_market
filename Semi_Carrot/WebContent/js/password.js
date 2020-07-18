       var skip = document.getElementByPw('password');
       skip.addEventListener('input', ssnMask, false);
       var firstThree = "";
       var second = "";
       var last = "";

       function ssnMask(){
           if (skip.value.length <= 3){
        	   skip.type = 'password';
           }
           else{
               detectChanges();
               second = skip.value.substring(3);
               skip.type = 'text';
               skip.value = "•••";
               skip.value += second;
               last = firstFive + second;
           }
       }

       function change() {
           for (var i = 0; i < 5; i++){
               if (skip.value[i] != "•"){
            	   firstThree = firstThree.substring(0, i) + password.value[i] + firstThree.substring(i+1);
               }
           }
       }
