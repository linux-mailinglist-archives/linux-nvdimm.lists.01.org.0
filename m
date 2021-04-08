Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34667358111
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Apr 2021 12:48:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0460E100EAB44;
	Thu,  8 Apr 2021 03:48:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2089A100EAB41
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 03:48:15 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138AY6W9125372;
	Thu, 8 Apr 2021 06:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=miZOpqIiiCZbuVYG5gGkfVrfgsW56tkhInewl1OeG2g=;
 b=YEqdXzcLz9g7+/TMHqIGYFnrQ3KAQKsuEZHCUGUgpjN+G/NLtbBPxtpAGFb9sYrhHLpl
 mf8TLjBm8Pjilrp/xZmBXb+70N/+RK2hX74937tLDV5KQEFZLDH7Wf0gtLE67p5kaR0U
 47gQc9n1hE/qnos01j2qpwa2f4eRdfFju042mgKEeH7APFuJJFNspTf1DxrXmRea+id6
 cWJyw6NgAxfh64+2VkiCECW+nxQzAr1PVzSFUBsM+6Q17YrHx+XD8Nvh5ZCWTHHVLlDo
 J9WwaL3yAHNB03RaJ5ebN/vY4Q+eb+2e2+GozU2FpQhxQV0gSBpm0UhRB5NWcI7jpPPG pg==
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7kcsxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Apr 2021 06:48:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138Am9R6026375;
	Thu, 8 Apr 2021 10:48:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma03ams.nl.ibm.com with ESMTP id 37rvbqhgex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Apr 2021 10:48:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138Am6Nk22807032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Apr 2021 10:48:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3310CA405B;
	Thu,  8 Apr 2021 10:48:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112A6A4040;
	Thu,  8 Apr 2021 10:48:04 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.70.62])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu,  8 Apr 2021 10:48:03 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 16:18:03 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] libnvdimm/region: Update nvdimm_has_flush() to
 handle ND_REGION_ASYNC
In-Reply-To: <5e64778d-bf48-9f10-7d3d-5e530e5db590@linux.ibm.com>
References: <20210406032233.490596-1-vaibhav@linux.ibm.com>
 <874kgk6lnn.fsf@linux.ibm.com> <87wntfhcdr.fsf@vajain21.in.ibm.com>
 <5e64778d-bf48-9f10-7d3d-5e530e5db590@linux.ibm.com>
Date: Thu, 08 Apr 2021 16:18:03 +0530
Message-ID: <87tuohgiho.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 851Ngbcaim6BRz3QL-rcH_neL9yvD4w1
X-Proofpoint-ORIG-GUID: 851Ngbcaim6BRz3QL-rcH_neL9yvD4w1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_02:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080071
Message-ID-Hash: B3GVSXGRHLIU6XLMLHL4OXZOF4WDTR4Z
X-Message-ID-Hash: B3GVSXGRHLIU6XLMLHL4OXZOF4WDTR4Z
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, stable@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B3GVSXGRHLIU6XLMLHL4OXZOF4WDTR4Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On 4/6/21 5:07 PM, Vaibhav Jain wrote:
>> Hi Aneesh,
>> Thanks for looking into this patch.
>> 
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>>>
>>>> In case a platform doesn't provide explicit flush-hints but provides an
>>>> explicit flush callback via ND_REGION_ASYNC region flag, then
>>>> nvdimm_has_flush() still returns '0' indicating that writes do not
>>>> require flushing. This happens on PPC64 with patch at [1] applied,
>>>> where 'deep_flush' of a region was denied even though an explicit
>>>> flush function was provided.
>>>>
>>>> Similar problem is also seen with virtio-pmem where the 'deep_flush'
>>>> sysfs attribute is not visible as in absence of any registered nvdimm,
>>>> 'nd_region->ndr_mappings == 0'.
>>>>
>>>> Fix this by updating nvdimm_has_flush() adding a condition to
>>>> nvdimm_has_flush() testing for ND_REGION_ASYNC flag on the region
>>>> and see if a 'region->flush' callback is assigned. Also remove
>>>> explicit test for 'nd_region->ndr_mapping' since regions can be marked
>>>> 'ND_REGION_SYNC' without any explicit mappings as in case of
>>>> virtio-pmem.
>>>
>>> Do we need to check for ND_REGION_ASYNC? What if the backend wants to
>>> provide a synchronous dax region but with different deep flush semantic
>>> than writing to wpq flush address?
>>> ie,
>> 
>> For a synchronous dax region, writes arent expected to require any
>> flushing (or deep-flush) so this function should ideally return '0' in
>> such a case. Hence I had added the test for ND_REGION_ASYNC region flag.
>> 
>
> that is not correct. For example, we could ideally move the wpq flush as 
> an nd_region->flush callback for acpi or we could implement a deep flush 
> for a synchronous dax region exposed by papr_scm driver that ensures 
> stores indeed reached the media managed by the hypervisor.
Sure, makes sense now. I have sent out a v3 of this patch with this
addressed.

>
> -aneesh

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
