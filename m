Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9831001C9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Nov 2019 10:52:18 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC73E100DC3FA;
	Mon, 18 Nov 2019 01:53:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1FB41100DC3F9
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 01:53:14 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI9ppF0069021;
	Mon, 18 Nov 2019 04:52:09 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wayf4xwg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2019 04:52:08 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAI9o4s1006441;
	Mon, 18 Nov 2019 09:52:07 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma02wdc.us.ibm.com with ESMTP id 2wa8r61676-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2019 09:52:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI9q7mZ61014302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2019 09:52:07 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E537478060;
	Mon, 18 Nov 2019 09:52:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB5F078069;
	Mon, 18 Nov 2019 09:52:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.246])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2019 09:52:00 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size validation arch dependent
In-Reply-To: <CAPcyv4hroohsrXT1YHQB-L8ZFa2kUW+bKy03We4Mt7afeJgu3Q@mail.gmail.com>
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com> <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com> <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com> <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com> <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com> <87o8xp5lo9.fsf@linux.ibm.com> <8736eohva1.fsf@linux.ibm.com> <CAPcyv4hroohsrXT1YHQB-L8ZFa2kUW+bKy03We4Mt7afeJgu3Q@mail.gmail.com>
Date: Mon, 18 Nov 2019 15:21:57 +0530
Message-ID: <87o8x9h5qa.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180088
Message-ID-Hash: NUKDJCWIIXMIBLQVGUULOBT3OXM263EG
X-Message-ID-Hash: NUKDJCWIIXMIBLQVGUULOBT3OXM263EG
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUKDJCWIIXMIBLQVGUULOBT3OXM263EG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Sat, Nov 16, 2019 at 4:15 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>

....


>>
>> Considering the direct-map map size is not going to be user selectable,
>> do you agree that we can skip the above step 0 configuration you
>> suggested.
>>
>> The changes proposed in the patch series essentially does the rest.
>>
>> 1) It validate the size against the arch specific limit during
>> namespace creation. (part of step 1)
>
> This validation is a surprise failure to ndctl.
>
>> 2) It also disable initializing a region if it find the size not
>> correctly aligned as per the platform requirement.
>
> There needs to be a way for the user to discover the correct alignment
> that the kernel will accept.
>
>> 3) Direct map  mapping size is different from supported_alignment for a
>> namespace. The supported alignment controls what possible PAGE SIZE user want the
>> namespace to be mapped to user space.
>
> No, the namespace alignment is different than the page mapping size.
> The alignment is only interpreted as a mapping size at the device-dax
> level, otherwise at the raw namespace level it's just an arbitrary
> alignment.
>
>> With the above do you think the current patch series is good?
>
> I don't think we've quite converged on a solution.

How about we make it a property of seed device. ie,
we add `supported_size_align` RO attribute to the seed device. ndctl can
use this to validate the size value. So this now becomes step0

sys/bus/nd/devices/region0> cat btt0.0/supported_size_align 
16777216
/sys/bus/nd/devices/region0> cat pfn0.0/supported_size_align 
16777216
/sys/bus/nd/devices/region0> cat dax0.0/supported_size_align 
16777216
/sys/bus/nd/devices/region0>

We follow that up with validating the size value written to size
attribute(step 1).

While initializing the namespaces already present in a region we again
validate the size and if not properly aligned we mark the region
disabled.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
