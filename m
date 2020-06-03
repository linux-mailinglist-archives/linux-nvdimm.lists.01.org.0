Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC551ED486
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 18:49:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D1B6100A6417;
	Wed,  3 Jun 2020 09:44:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50398100A6416
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 09:44:33 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053Gg0Yh095711;
	Wed, 3 Jun 2020 12:49:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31dr8hxveg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 12:49:29 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 053Gj2u4110190;
	Wed, 3 Jun 2020 12:49:28 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31dr8hxvdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 12:49:28 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 053Gjfwl018866;
	Wed, 3 Jun 2020 16:49:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03fra.de.ibm.com with ESMTP id 31bf47bdtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 16:49:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 053GnNnH55771390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2020 16:49:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3EEDA4064;
	Wed,  3 Jun 2020 16:49:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 132CCA4060;
	Wed,  3 Jun 2020 16:49:20 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.71.48])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2020 16:49:19 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 03 Jun 2020 22:19:18 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v5 2/6] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
In-Reply-To: <67eb2e50aa65509f16e63dc33d1ff5e88b4b5496.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com> <20200529220600.225320-3-vaibhav@linux.ibm.com> <2960499ffc4f5f3f3ab305eaba84c2bca15b45ae.camel@intel.com> <87zh9kh3pq.fsf@linux.ibm.com> <67eb2e50aa65509f16e63dc33d1ff5e88b4b5496.camel@intel.com>
Date: Wed, 03 Jun 2020 22:19:18 +0530
Message-ID: <87v9k8gkmp.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_13:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=1
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030130
Message-ID-Hash: DLXEIAIRNRQ22Z5I5QO2S77XCLXXD3KU
X-Message-ID-Hash: DLXEIAIRNRQ22Z5I5QO2S77XCLXXD3KU
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DLXEIAIRNRQ22Z5I5QO2S77XCLXXD3KU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Wed, 2020-06-03 at 15:27 +0530, Vaibhav Jain wrote:
>> > 
>> > Two things here:
>> > 1. Why not use the new ndctl_bus_has_of_node helper here? and
>> > 2. This looks redundant. add_papr_dimm() is only called if
>> > ndctl_bus_has_of_node() during add_dimm.
>> Presently we have two different nvdimm implementations:
>> 
>> * papr-scm: handled by arch/powerpc/platforms/pseries/papr_scm kernel module.
>> * nvdimm-n: handled by drivers/nvdimm/of_pmem kernel module.
>> 
>> Both nvdimms are exposed to the kernel via device tree nodes but different
>> 'compatible' properties. This patchset only adds support for 'papr-scm'
>> compatible nvdimms.
>> 
>> 'ndctl_bus_has_of_node()' simply indicates if the nvdimm has an
>> open-firmware compatible devicetree node associated with it and doesnt
>> necessarily indicate if its papr-scm compliant.
>> 
>> Hence validating the 'compatible' attribute value is necessary here.
>> Please see a more detailed info below regarding the 'compatible' sysfs
>> attribute.
>> 
> Understood - one more question:
>
> Would it be useful to wrap the 'compatible' check into an API similar to
> _has_of_node - say ndctl_bus_is_papr_compatible()? I'm not too strongly
> attached this, there is only one user so far after all, but it seemed
> like an easy thing that might get copy-pasted around in the future.

Yes, sounds good to me. Should simplify the add_papr_dimm() function a
bit as I can just call ndctl_bus_is_papr_compatible() and if true then
setup the cmd_family.

Will roll out this change in v6 iteration.

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
