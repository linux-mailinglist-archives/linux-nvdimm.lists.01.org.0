Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC27289E7A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Oct 2020 06:59:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12C6D15A6E227;
	Fri,  9 Oct 2020 21:59:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 469D315A6E225
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 21:59:19 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09A4oisw060035;
	Sat, 10 Oct 2020 00:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=9UawxoC2HHKkBe2OryDbseGZLMitLfUQER1BZ0mp8bw=;
 b=m58YXQq6jZJabTandgKrgZP9BTPiBzDQDdE8l7QfHnBWctH9xTMsPYX1A0xXWTwSXGFq
 S28iUsMvNq0eQO1VWDw3zH8dGnvdylfX/YgFQz3CuQRk6bBuk5iA2bYJ6+0tetQ0rgmF
 R5dsmYnSnjhUasqD07I/PMfeCPhG45Vga3EuoLNppd+eXJgGs7O76kgFrY7qyKkVHC2W
 fyo8SekZxHKM+rEeT1f67GloUfJyOU0ULTfI1aD+YLuyQPPr91ZW9ztKMf9krc77iTgK
 jZiyYLUuXao/gsI4qEvBR3RDM49qstjeO1A9LX+12Qx9goSVEpbij4m6F16DFnoJFn9r 2A==
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3435e911t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2020 00:59:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09A4vwPI025703;
	Sat, 10 Oct 2020 04:59:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 3434k7r26b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2020 04:59:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09A4x8pQ25756064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Oct 2020 04:59:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5F9A4051;
	Sat, 10 Oct 2020 04:59:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB41DA404D;
	Sat, 10 Oct 2020 04:59:05 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.77.203.213])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Sat, 10 Oct 2020 04:59:05 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Sat, 10 Oct 2020 10:29:04 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        "Verma, Vishal L"
 <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] libndctl: Fix probe of non-nfit nvdimms
In-Reply-To: <CAPcyv4j89a_Nevq1y92UPGedm74VUYCunkf62T5S3UeXzW6vKg@mail.gmail.com>
References: <20201009120009.243108-1-vaibhav@linux.ibm.com>
 <145db3d86fa6bddf55c0e7c4aa149984676cd723.camel@intel.com>
 <CAPcyv4j89a_Nevq1y92UPGedm74VUYCunkf62T5S3UeXzW6vKg@mail.gmail.com>
Date: Sat, 10 Oct 2020 10:29:04 +0530
Message-ID: <87pn5qy8vb.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-10_01:2020-10-09,2020-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010100042
Message-ID-Hash: QDYHWTRGNN2VJ3B4YSRTQD32B4HLYM22
X-Message-ID-Hash: QDYHWTRGNN2VJ3B4YSRTQD32B4HLYM22
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QDYHWTRGNN2VJ3B4YSRTQD32B4HLYM22/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan and Vishal,

Thanks so much for quick turnaround on this.

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Oct 9, 2020 at 11:36 AM Verma, Vishal L
> <vishal.l.verma@intel.com> wrote:
>>
>> On Fri, 2020-10-09 at 17:30 +0530, Vaibhav Jain wrote:
>> > commit 107a24ff429f ("ndctl/list: Add firmware activation
>> > enumeration") introduced changes in add_dimm() to enumerate the status
>> > of firmware activation. However a branch added in that commit broke
>> > the probe for non-nfit nvdimms like one provided by papr-scm. This
>> > cause an error reported when listing namespaces like below:
>> >
>> > $ sudo ndctl list
>> > libndctl: add_dimm: nmem0: probe failed: No such device
>> > libndctl: __sysfs_device_parse: nmem0: add_dev() failed
>> >
>> > Do a fix for this by removing the offending branch in the add_dimm()
>> > patch. This continues the flow of add_dimm() probe even if the nfit is
>> > not detected on the associated bus.
>> >
>> > Fixes: 107a24ff429fa("ndctl/list: Add firmware activation enumeration")
>> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> > ---
>> >  ndctl/lib/libndctl.c | 3 ---
>> >  1 file changed, 3 deletions(-)
>>
>> Ah apologies - this snuck in when I reflowed Dan's patches on top of the
>> papr work for v70.
No worries :-)

>>
>> I expect you'd like a point release with this fix asap?
Yes, that will be great. Thanks

>>
>> Is there a way for me to incorporate some papr unit tests into my
>> release workflow so I can avoid breaking things like this again?
>>
>> I'll also try to do a better job of pushing things out to the pending
>> branch more frequently so if you're monitoring that branch, hopefully
>> things like this will get caught before a release happens :)

Fully agree, if that happens we can incorporate it into our CI system to
ensure that such regressions are caught early on before any release is
tagged.

>
> Would be nice to have something like a papr_test next to nfit_test for
> such regression testing. These kinds of mistakes are really only
> avoidable with regression tests.
Yes Agree, fortunatly Santosh  has recently posted an RFC patchset
implementing such tests at [1]. Once that gets merged, can used to
perform regression testing.

[1] "testing/nvdimm: Add test module for non-nfit platforms"
https://lore.kernel.org/linux-nvdimm/20201006010013.848302-1-santosh@fossix.org/

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
