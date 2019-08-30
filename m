Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0DA2EA8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Aug 2019 06:45:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C19F2021EBDA;
	Thu, 29 Aug 2019 21:47:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0BA9202110C1
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 21:47:01 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7U4hGTd102871; Fri, 30 Aug 2019 00:45:12 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2umpb54x9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2019 00:45:12 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U4dnFL027487;
 Fri, 30 Aug 2019 04:45:11 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 2ujvv796qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2019 04:45:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7U4j9RZ42074564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2019 04:45:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 866947805E;
 Fri, 30 Aug 2019 04:45:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC75F7805F;
 Fri, 30 Aug 2019 04:45:08 +0000 (GMT)
Received: from [9.199.37.186] (unknown [9.199.37.186])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 30 Aug 2019 04:45:08 +0000 (GMT)
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
To: Dan Williams <dan.j.williams@intel.com>
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
 <156711523501.12658.8795324273505326478.git-patchwork-notify@kernel.org>
 <87lfvbnujk.fsf@linux.ibm.com>
 <CAPcyv4g7nQ201DV6r1-2Jq2vyHWzstHD2txwZvR5z6NMY_mqiw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <ccf23b5e-4dc8-14c6-31db-cef3bfdf7269@linux.ibm.com>
Date: Fri, 30 Aug 2019 10:15:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g7nQ201DV6r1-2Jq2vyHWzstHD2txwZvR5z6NMY_mqiw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-30_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300048
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/30/19 10:10 AM, Dan Williams wrote:
> On Thu, Aug 29, 2019 at 9:31 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> patchwork-bot+linux-nvdimm@kernel.org writes:
>>
>>> Hello:
>>>
>>> This patch was applied to nvdimm/nvdimm.git (refs/heads/libnvdimm-for-next).
>>>
>>> On Wed,  7 Aug 2019 09:30:29 +0530 you wrote:
>>>> ndctl utility requires the ndbus to have unique names. If not while
>>>> enumerating the bus in userspace it drops bus with similar names.
>>>> This results in us not listing devices beneath the bus.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>   drivers/nvdimm/of_pmem.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>
>>> Here is a summary with links:
>>>    - nvdimm/of_pmem: Provide a unique name for bus provider
>>>      https://git.kernel.org/nvdimm/nvdimm/c/49bddc73d15c25a68e4294d76fc74519fda984cd
>>>
>>> You are awesome, thank you!
>>
>> We decided to fix this in ndctl tool? If we go with ndctl fix, we
>> can drop the kernel change.
> 
> Oh, I was planning to do both any concerns if I keep the kernel
> change, otherwise I'll need to rebase the branch.
> 

I guess rebasing is not going to be nice. So we can keep the patch and 
if we are really need to move the provider name to indicate backend 
driver, I will fixup both of_pmem and papr_scm together.

Thanks.
-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
