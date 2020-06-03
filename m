Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B51ED32F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 17:20:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54FA1100A6416;
	Wed,  3 Jun 2020 08:15:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1AB9010112D6D
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 08:15:23 -0700 (PDT)
IronPort-SDR: yrFpJ8NVd2HRSJ1GY60xYVTp9FrG3JCkwxFEemRpmDL4KKpR6AdcDLlqW8Z1InJtdH8TUsxhPn
 0zWP4V1AkV9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:20:21 -0700
IronPort-SDR: zcrfdh0JW6JEMpvLSnGgKVjIzFOBHwOh8PhpR5kBX/HD70ostt1qX6/t3wPVh99/4jrlfz/42/
 XG39tDWT5kRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400";
   d="scan'208";a="445145277"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 08:20:21 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 08:20:20 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.25]) with mapi id 14.03.0439.000;
 Wed, 3 Jun 2020 08:20:20 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v5 2/6] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR nvdimm family
Thread-Topic: [ndctl PATCH v5 2/6] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR nvdimm family
Thread-Index: AQHWNgVrYu93SLPBr0Kz9r0KmQnTSqjG3kcAgABFsoCAAFpPAA==
Date: Wed, 3 Jun 2020 15:20:20 +0000
Message-ID: <67eb2e50aa65509f16e63dc33d1ff5e88b4b5496.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
	 <20200529220600.225320-3-vaibhav@linux.ibm.com>
	 <2960499ffc4f5f3f3ab305eaba84c2bca15b45ae.camel@intel.com>
	 <87zh9kh3pq.fsf@linux.ibm.com>
In-Reply-To: <87zh9kh3pq.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <0BBCC20D6EBAE440AE32ABA6F0430C5C@intel.com>
MIME-Version: 1.0
Message-ID-Hash: U2JJ5JC4ENL26WPBJB5MMWDKWENMTNWC
X-Message-ID-Hash: U2JJ5JC4ENL26WPBJB5MMWDKWENMTNWC
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U2JJ5JC4ENL26WPBJB5MMWDKWENMTNWC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-06-03 at 15:27 +0530, Vaibhav Jain wrote:
> > 
> > Two things here:
> > 1. Why not use the new ndctl_bus_has_of_node helper here? and
> > 2. This looks redundant. add_papr_dimm() is only called if
> > ndctl_bus_has_of_node() during add_dimm.
> Presently we have two different nvdimm implementations:
> 
> * papr-scm: handled by arch/powerpc/platforms/pseries/papr_scm kernel module.
> * nvdimm-n: handled by drivers/nvdimm/of_pmem kernel module.
> 
> Both nvdimms are exposed to the kernel via device tree nodes but different
> 'compatible' properties. This patchset only adds support for 'papr-scm'
> compatible nvdimms.
> 
> 'ndctl_bus_has_of_node()' simply indicates if the nvdimm has an
> open-firmware compatible devicetree node associated with it and doesnt
> necessarily indicate if its papr-scm compliant.
> 
> Hence validating the 'compatible' attribute value is necessary here.
> Please see a more detailed info below regarding the 'compatible' sysfs
> attribute.
> 
Understood - one more question:

Would it be useful to wrap the 'compatible' check into an API similar to
_has_of_node - say ndctl_bus_is_papr_compatible()? I'm not too strongly
attached this, there is only one user so far after all, but it seemed
like an easy thing that might get copy-pasted around in the future.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
