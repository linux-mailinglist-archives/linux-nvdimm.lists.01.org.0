Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423EB345918
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 08:53:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C6BE100EBB82;
	Tue, 23 Mar 2021 00:53:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5CF8100EC1EB
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 00:53:47 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12N7Z27o124537;
	Tue, 23 Mar 2021 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=scB0dVeff3XvA4OhUb5UTJEp+fe5hq/ZV3SA57L8xgE=;
 b=QFI9XrQpe4+Bw49WM/8gpNAC6E08fE3DoQrvPDlprd5gCKdC8wGkn64kUQeT6jok3QgJ
 Ayg1qc9fEgudrb8yxeebv+qkzXNR0SBUUpmd2OCiHWbyB+c7hS8hyP+GA9E7+knOAl2g
 Zd67YY4SYhqeXmg4trWjH2cGsOy7AyCACKv6+2Y4mTFgknmKOAfLyZ8VRhCUhlWQi5mX
 EDAaH0dpNwmu0FLpxJinJrk5hYv3qJLLiSKn3Ur3xU48f8r6k/3IAXNiJAoxFcrGCVAm
 D7Wxcc+QrEvSz5EVFI0Sf71RTHlmNccJjJNccH5jkg+sfv/0phdphumbYZ/MIEjr6F9P kQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37ef6n2rqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 03:53:40 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12N7Z9lQ124946;
	Tue, 23 Mar 2021 03:53:40 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37ef6n2rqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 03:53:39 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12N7mBCL014250;
	Tue, 23 Mar 2021 07:53:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma01fra.de.ibm.com with ESMTP id 37d99xhm62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 07:53:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12N7rZBI36766096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Mar 2021 07:53:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D84511C050;
	Tue, 23 Mar 2021 07:53:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9029911C04C;
	Tue, 23 Mar 2021 07:53:32 +0000 (GMT)
Received: from [9.199.35.201] (unknown [9.199.35.201])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 23 Mar 2021 07:53:32 +0000 (GMT)
Subject: Re: [RFC Qemu PATCH v2 1/2] spapr: drc: Add support for async hcalls
 at the drc level
To: David Gibson <david@gibson.dropbear.id.au>
References: <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
 <160674938210.2492771.1728601884822491679.stgit@lep8c.aus.stglabs.ibm.com>
 <20201221130853.15c8ddfd@bahia.lan> <20201228083800.GN6952@yekko.fritz.box>
 <3b47312a-217f-8df5-0bfd-1a653598abad@linux.ibm.com>
 <20210208062122.GA40668@yekko.fritz.box>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <0c3591b8-e2bd-3a7a-112f-e410bca4434f@linux.ibm.com>
Date: Tue, 23 Mar 2021 13:23:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210208062122.GA40668@yekko.fritz.box>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_02:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230053
Message-ID-Hash: 2GDVYPSS2NL4B6P6KROOWSJIIERJ5OXU
X-Message-ID-Hash: 2GDVYPSS2NL4B6P6KROOWSJIIERJ5OXU
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kurz <groug@kaod.org>, xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, linux-nvdimm@lists.01.org, aneesh.kumar@linux.ibm.com, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2GDVYPSS2NL4B6P6KROOWSJIIERJ5OXU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi David,

Sorry about the delay.

On 2/8/21 11:51 AM, David Gibson wrote:
> On Tue, Jan 19, 2021 at 12:40:31PM +0530, Shivaprasad G Bhat wrote:
>> Thanks for the comments!
>>
>>
>> On 12/28/20 2:08 PM, David Gibson wrote:
>>
>>> On Mon, Dec 21, 2020 at 01:08:53PM +0100, Greg Kurz wrote:
>> ...
>>>> The overall idea looks good but I think you should consider using
>>>> a thread pool to implement it. See below.
>>> I am not convinced, however.  Specifically, attaching this to the DRC
>>> doesn't make sense to me.  We're adding exactly one DRC related async
>>> hcall, and I can't really see much call for another one.  We could
>>> have other async hcalls - indeed we already have one for HPT resizing
>>> - but attaching this to DRCs doesn't help for those.
>> The semantics of the hcall made me think, if this is going to be
>> re-usable for future if implemented at DRC level.
> It would only be re-usable for operations that are actually connected
> to DRCs.  It doesn't seem to me particularly likely that we'll ever
> have more asynchronous hcalls that are also associated with DRCs.
Okay

>> Other option
>> is to move the async-hcall-state/list into the NVDIMMState structure
>> in include/hw/mem/nvdimm.h and handle it with machine->nvdimms_state
>> at a global level.
> I'm ok with either of two options:
>
> A) Implement this ad-hoc for this specific case, making whatever
> simplifications you can based on this specific case.

I am simplifying it to nvdimm use-case alone and limiting the scope.


> B) Implement a general mechanism for async hcalls that is *not* tied
> to DRCs.  Then use that for the existing H_RESIZE_HPT_PREPARE call as
> well as this new one.
>
>> Hope you are okay with using the pool based approach that Greg
> Honestly a thread pool seems like it might be overkill for this
> application.

I think its appropriate here as that is what is being done by virtio-pmem

too for flush requests. The aio infrastructure simplifies lot of the

thread handling usage. Please suggest if you think there are better ways.


I am sending the next version addressing all the comments from you and Greg.


Thanks,

Shivaprasad
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
