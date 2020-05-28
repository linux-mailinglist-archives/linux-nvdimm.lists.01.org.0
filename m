Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1371E69E5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 May 2020 20:59:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83BA9122E0E67;
	Thu, 28 May 2020 11:55:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 51D04122E0E66
	for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 11:55:03 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SI2aIn064132;
	Thu, 28 May 2020 14:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=+sH7Mt3EZMximHDL5xK8GGzd86pvVvQrxDzdsOg0GZI=;
 b=sUhoxBcL0xIkDJPByfobgdJ6/NoqDS1v6GjK5lyPgyOQSbVhhE+5saM8cYWa6KvFqfus
 MF5kCAF7vSncC9iA0TjQKCkeSSDYorCN+GTGCLzYkfaWwuWa8HiqECmKZwJF3yZ+sknM
 fgnrltvQcuJXxItFRMEffsglI/DxDHSDIETTDFWI2qr4cZxzRSDYnVZtHzvQnr2NiYhZ
 JjqBMRnf9HZmnpFlnuQP7EWYTq/SStNVGIQ66iRd7oy+yXKxbQ/dL53fq63QYdZbN40K
 nL392IP6eIZMo79SMXEnY6F51dX4Hio04SM5glXiawDn2W9QfLoeIqis4Ebho5SGOBoj Fw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31agtdvam3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2020 14:59:17 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04SIVJqS166479;
	Thu, 28 May 2020 14:59:16 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31agtdvakh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2020 14:59:16 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SIpPlU012181;
	Thu, 28 May 2020 18:59:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 316uf8aewf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2020 18:59:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04SIxCtL8716608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2020 18:59:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC1C11C054;
	Thu, 28 May 2020 18:59:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8CB011C04C;
	Thu, 28 May 2020 18:59:06 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.68.59])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 28 May 2020 18:59:06 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 29 May 2020 00:29:04 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: Feedback requested: Exposing NVDIMM performance statistics in a generic way
In-Reply-To: <CAPcyv4iTNK1ixzBRkm=09mHfrWzmd97HE4v-M2K5Uz0cKKT=3Q@mail.gmail.com>
References: <87d06swfr4.fsf@linux.ibm.com> <CAPcyv4jQmQceE_eptnfnrORfAUnikHConhchYLEUPARYRFOcbA@mail.gmail.com> <CAPcyv4iTNK1ixzBRkm=09mHfrWzmd97HE4v-M2K5Uz0cKKT=3Q@mail.gmail.com>
Date: Fri, 29 May 2020 00:29:04 +0530
Message-ID: <87r1v3lwcn.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_04:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=1 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280122
Message-ID-Hash: 6UQSKODUPXDLPDR6KGV2VIPYZHFFARR5
X-Message-ID-Hash: 6UQSKODUPXDLPDR6KGV2VIPYZHFFARR5
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@d-silva.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6UQSKODUPXDLPDR6KGV2VIPYZHFFARR5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for this taking time to look into this Dan,

Agree with the points you have made earlier that I am summarizing below:

* This is better done in ndctl rather than ipmctl.
* Should only expose general performance metrics and not performance
  counters. Performance counter should be exposed via perf
* Vendor specific metrics to be separated from generic performance
  metrics.

One way to split generic and vendor specific metrics might be to report
generic performance metrics together with dimm health metrics such as
"temprature_celsius" or "spares_percentage" that are already reported in
by dimm health output.

Vendor specific performance metrics can be reported as a seperate object
in the json output. Something similar to output below:

# ndctl list -DH --stats --vendor-stats
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"ok",
      "shutdown_state":"clean",
      "temperature_celsius":48.00,
      "spares_percentage":10,

      /* Generic performance metrics/stats */
      "TotalMediaReads": 18929,
      "TotalMediaWrites": 0,
      ....
    }
    
    /* Vendor specific stats for the dimm */
    "vendor-stats": {
    "Controller Reset Count":10
    "Controller Reset Elapsed Time": 3600
    "Power-on Seconds": 3600
    }
  }
]


Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, May 27, 2020 at 12:24 PM Dan Williams <dan.j.williams@intel.com> wrote:
> [..]
>> > This was done by adding two new dimm-ops callbacks that were
>> > implemented by the papr_scm implementation within libndctl. These
>> > callbacks are invoked by newly introduce code in 'util/json-smart.c'
>> > that format the returned stats from these new dimm-ops and transform
>> > them into a json-object to later presentation. I would request you to
>> > look at RFC patch-set[2] to understand the implementation details.
>>
>> I'm ok to add some stats to ndctl, but I want ndctl to be limited to
>> general statistics and not performance counters. Performance counters
>> and performance events should be abstracted through perf where
>> possible.
>
> Another aspect that helps common statistics is to expose them in
> sysfs. I'm going to go review your proposed ioctl mechanism, but I
> would hope that is reserved for multi-field command payloads that need
> to be sent as a unit rather than statistics retrieval that is amenable
> to a sysfs interface.

The patchset is using a machenism similar to GET_CONFIG_SIZE/DATA to
retrive a struct composed of tuples of (stat-id, stat-value) from
papr_scm and then exposes them to ndctl via some new dimm-ops.

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
