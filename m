Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DE245BF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 03:50:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 714A021274209;
	Mon, 20 May 2019 18:50:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DD35521274203
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 18:50:12 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L1nFqj053277;
 Tue, 21 May 2019 01:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dn+YYBqV56XU7F7c8CWuso5/+bxKEcmadpFPiXvJSds=;
 b=DdAorvBuJ54owqKG0kLG39NVx7aA0pnGQwqww2td+q3Q1tnyKKa/wLEQXTY+tsG2Te1d
 v3vE+2FjpNDnS77mfNnXh6YQrMpVPdIL7n6fpi4uJiroTlDpFR7MxG8tC55LHMiaw+5Y
 ReeZzbIVqmHfkYSiyZp86cOiDHWGhSRMMBqUqkqed1VfAde28N0s4YUo0tvaSys4mvBM
 0XigivNYS6TCuK6bakIVbsIkeTpREeiZfg103SbG9xE2gS1LMT2pHQlI+nUBSxbywcpN
 8n2ukoqn5/SEAUsMPplFXfogsWXKud+1bO0wbsQUQ6haFsLfiPuSsLGADUM71mZ7jROQ Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2sjapqa6sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2019 01:50:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L1nYqf031921;
 Tue, 21 May 2019 01:50:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2sks1xww56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2019 01:50:04 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4L1o4tS000757;
 Tue, 21 May 2019 01:50:04 GMT
Received: from [10.159.155.76] (/10.159.155.76)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 21 May 2019 01:50:04 +0000
Subject: Re: [PATCH] mm, memory-failure: clarify error message
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
References: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
 <512532de-4c09-626d-380f-58cef519166b@arm.com>
 <20190520102106.GA12721@hori.linux.bs1.fc.nec.co.jp>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <49fd8918-5762-9b92-d383-8fdd96cf1c38@oracle.com>
Date: Mon, 20 May 2019 18:50:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520102106.GA12721@hori.linux.bs1.fc.nec.co.jp>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210009
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210009
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Thanks Vishal and Naoya!

-jane

On 5/20/2019 3:21 AM, Naoya Horiguchi wrote:
> On Fri, May 17, 2019 at 10:18:02AM +0530, Anshuman Khandual wrote:
>>
>> On 05/17/2019 09:38 AM, Jane Chu wrote:
>>> Some user who install SIGBUS handler that does longjmp out
>> What the longjmp about ? Are you referring to the mechanism of catching the
>> signal which was registered ?
> AFAIK, longjmp() might be useful for signal-based retrying, so highly
> optimized applications like Oracle DB might want to utilize it to handle
> memory errors in application level, I guess.
>
>>> therefore keeping the process alive is confused by the error
>>> message
>>>    "[188988.765862] Memory failure: 0x1840200: Killing
>>>     cellsrv:33395 due to hardware memory corruption"
>> Its a valid point because those are two distinct actions.
>>
>>> Slightly modify the error message to improve clarity.
>>>
>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>> ---
>>>   mm/memory-failure.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index fc8b517..14de5e2 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -216,10 +216,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>>>   	short addr_lsb = tk->size_shift;
>>>   	int ret;
>>>   
>>> -	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
>>> -		pfn, t->comm, t->pid);
>>> -
>>>   	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
>>> +		pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory "
>>> +			"corruption\n", pfn, t->comm, t->pid);
>>>   		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
>>>   				       addr_lsb, current);
>>>   	} else {
>>> @@ -229,6 +228,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>>>   		 * This could cause a loop when the user sets SIGBUS
>>>   		 * to SIG_IGN, but hopefully no one will do that?
>>>   		 */
>>> +		pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware "
>>> +			"memory corruption\n", pfn, t->comm, t->pid);
>>>   		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>>>   				      addr_lsb, t);  /* synchronous? */
>> As both the pr_err() messages are very similar, could not we just switch between "Killing"
>> and "Sending SIGBUS to" based on a variable e.g action_[kill|sigbus] evaluated previously
>> with ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm).
> That might need additional if sentence, which I'm not sure worth doing.
> I think that the simplest fix for the reported problem (a confusing message)
> is like below:
>
> 	-	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
> 	+	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> 			pfn, t->comm, t->pid);
>
> Or, if we have a good reason to separate the message for MF_ACTION_REQUIRED and
> MF_ACTION_OPTIONAL, that might be OK.
>
> Thanks,
> Naoya Horiguchi
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
