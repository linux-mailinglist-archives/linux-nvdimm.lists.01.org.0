Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A735531A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Apr 2021 14:05:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 61C9C100EB84F;
	Tue,  6 Apr 2021 05:05:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21D3E100EB84D
	for <linux-nvdimm@lists.01.org>; Tue,  6 Apr 2021 05:05:54 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136C4tvE168627;
	Tue, 6 Apr 2021 08:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SRb8fRuRg+pcdNraxXF8tQx5ilSUBAgqzQiletW5yOc=;
 b=UjqW0vfpAHf6ZafpwZF5mQe46dh9iLhRNoYGdrpl45nltDlu4HAUIfZnsx5s1w0DketD
 jVYAOJpC4PGm9hxRq54/JVmce6JitFVjI1RHPxKIohVdiQivv8zB6vaKiPCfXglue0xg
 YCc1puu9DvHB+H2ZCFNInMOu0FQtVNARFeSOYnsuH81R7qCNvUImqhT6fcXxw17U90zf
 0HnH/IKnNHS6N8kWjgVb3H+B2UNgC2YN0Ajyt0kPtOWpDQV15rVlOro+SmvHf/vRLKf2
 NJEzYmz2Eig1NCQ+TDFrX1x5Y60XSSuFeMDP0qdWY6tFf9FX4wbsxCl+KDNFnfmH0Jz6 kQ==
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37q5pb0pb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Apr 2021 08:05:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136C2skp012531;
	Tue, 6 Apr 2021 12:05:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 37q2n2t4mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Apr 2021 12:05:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136C5Owc22675728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Apr 2021 12:05:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAAEEAE04D;
	Tue,  6 Apr 2021 12:05:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971C7AE056;
	Tue,  6 Apr 2021 12:05:43 +0000 (GMT)
Received: from [9.102.1.249] (unknown [9.102.1.249])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  6 Apr 2021 12:05:43 +0000 (GMT)
Subject: Re: [PATCH v2] libnvdimm/region: Update nvdimm_has_flush() to handle
 ND_REGION_ASYNC
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org
References: <20210406032233.490596-1-vaibhav@linux.ibm.com>
 <874kgk6lnn.fsf@linux.ibm.com> <87wntfhcdr.fsf@vajain21.in.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <5e64778d-bf48-9f10-7d3d-5e530e5db590@linux.ibm.com>
Date: Tue, 6 Apr 2021 17:35:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87wntfhcdr.fsf@vajain21.in.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nXSn_XzIUabCrdAZOSrwrXY3zWEy-49P
X-Proofpoint-GUID: nXSn_XzIUabCrdAZOSrwrXY3zWEy-49P
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_03:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060080
Message-ID-Hash: ABQUJ6FKCSUMAKYAA4X7T4ICFRYPVDQ6
X-Message-ID-Hash: ABQUJ6FKCSUMAKYAA4X7T4ICFRYPVDQ6
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, stable@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ABQUJ6FKCSUMAKYAA4X7T4ICFRYPVDQ6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 4/6/21 5:07 PM, Vaibhav Jain wrote:
> Hi Aneesh,
> Thanks for looking into this patch.
> 
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>>
>>> In case a platform doesn't provide explicit flush-hints but provides an
>>> explicit flush callback via ND_REGION_ASYNC region flag, then
>>> nvdimm_has_flush() still returns '0' indicating that writes do not
>>> require flushing. This happens on PPC64 with patch at [1] applied,
>>> where 'deep_flush' of a region was denied even though an explicit
>>> flush function was provided.
>>>
>>> Similar problem is also seen with virtio-pmem where the 'deep_flush'
>>> sysfs attribute is not visible as in absence of any registered nvdimm,
>>> 'nd_region->ndr_mappings == 0'.
>>>
>>> Fix this by updating nvdimm_has_flush() adding a condition to
>>> nvdimm_has_flush() testing for ND_REGION_ASYNC flag on the region
>>> and see if a 'region->flush' callback is assigned. Also remove
>>> explicit test for 'nd_region->ndr_mapping' since regions can be marked
>>> 'ND_REGION_SYNC' without any explicit mappings as in case of
>>> virtio-pmem.
>>
>> Do we need to check for ND_REGION_ASYNC? What if the backend wants to
>> provide a synchronous dax region but with different deep flush semantic
>> than writing to wpq flush address?
>> ie,
> 
> For a synchronous dax region, writes arent expected to require any
> flushing (or deep-flush) so this function should ideally return '0' in
> such a case. Hence I had added the test for ND_REGION_ASYNC region flag.
> 

that is not correct. For example, we could ideally move the wpq flush as 
an nd_region->flush callback for acpi or we could implement a deep flush 
for a synchronous dax region exposed by papr_scm driver that ensures 
stores indeed reached the media managed by the hypervisor.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
