Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CECED382499
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 08:43:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24CAA100EBB6E;
	Sun, 16 May 2021 23:43:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61E02100ED49E
	for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 23:43:34 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14H6XvD2122432;
	Mon, 17 May 2021 02:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xdx0NJHTH3TXuVcwAPTBaPY/tyOPa2y5gp9KZo5KBSk=;
 b=tXLjkVFaDsm8q/W9O2/Z2JLJgJfh0YA23k5Xh1QX9Sps+b5hOIfj5cPT3WxocUwQrmKJ
 8RCSVAIAjhV+WV82gyNFvZHM+hLxR45mQ5a6piiFeJs6V569a1rU9/UPoq4iqIb2xcNM
 JizJWqVkzqzt5wYW6v4pk7aVt9bh2d09WOdU/h8ymXVq9Q0VMtnlEuVz3Doa5E7kNbeB
 i/vp+o1wXst81rkJaKN121Qf2kb/iJM4GA7Ia12KvAtqX/PUpO1Srp4prfqykgz7tEE5
 uEWDRIP0HORfOlv+NefNKaKY7Xs5giRiXWJIxGMSQyfB4AcJHq6BCtZ+9YxcHKVfe7bf Gw==
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38kjmss77y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 May 2021 02:43:10 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14H6RFIi027591;
	Mon, 17 May 2021 06:43:09 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma01dal.us.ibm.com with ESMTP id 38j5x90ced-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 May 2021 06:43:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14H6h7n627853142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 May 2021 06:43:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80BC9BE051;
	Mon, 17 May 2021 06:43:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC879BE054;
	Mon, 17 May 2021 06:43:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.47.29])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 17 May 2021 06:43:02 +0000 (GMT)
Subject: Re: [RFC 1/4] drivers/nvdimm: Add perf interface to expose nvdimm
 performance stats
To: Peter Zijlstra <peterz@infradead.org>
References: <20210512163824.255370-1-kjain@linux.ibm.com>
 <20210512163824.255370-2-kjain@linux.ibm.com>
 <YJwP9ByvAcDPixVN@hirez.programming.kicks-ass.net>
 <37015d53-050a-acef-2958-b1ff5d02800b@linux.ibm.com>
 <YJ5jQ1ixz7D0Ij2R@hirez.programming.kicks-ass.net>
From: kajoljain <kjain@linux.ibm.com>
Message-ID: <f15d6de4-8152-4960-8716-16bd9a12357b@linux.ibm.com>
Date: Mon, 17 May 2021 12:13:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJ5jQ1ixz7D0Ij2R@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xDZBL9g-YAuBZJRqZNYjG2Yjrq2uXwea
X-Proofpoint-GUID: xDZBL9g-YAuBZJRqZNYjG2Yjrq2uXwea
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_01:2021-05-12,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=794
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170046
Message-ID-Hash: Y4J7BUJWPM6O76P7QEZ7N4PIEKTACVWI
X-Message-ID-Hash: Y4J7BUJWPM6O76P7QEZ7N4PIEKTACVWI
X-MailFrom: kjain@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, atrajeev@linux.vnet.ibm.com, tglx@linutronix.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y4J7BUJWPM6O76P7QEZ7N4PIEKTACVWI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/14/21 5:17 PM, Peter Zijlstra wrote:
> On Thu, May 13, 2021 at 05:56:14PM +0530, kajoljain wrote:
> 
>> But yes the current read/add/del functions are not adding value. We
>> could  add an arch/platform specific function which could handle the
>> capturing of the counter data and do the rest of the operation here,
>> is this approach better?
> 
> Right; have your register_nvdimm_pmu() set pmu->{add,del,read} to
> nd_pmu->{add,del,read} directly, don't bother with these intermediates.
> Also you can WARN_ON_ONCE() if any of them are NULL and fail
> registration at that point.
> 

Hi Peter,
    I will make all required changes and send next version of this patchset soon.

Thanks,
Kajol Jain
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
