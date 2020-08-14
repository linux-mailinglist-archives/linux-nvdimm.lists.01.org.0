Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F02442B3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Aug 2020 03:29:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8444111C82A86;
	Thu, 13 Aug 2020 18:29:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FDC611487767
	for <linux-nvdimm@lists.01.org>; Thu, 13 Aug 2020 18:29:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4BSQpH26BRz9sPB;
	Fri, 14 Aug 2020 11:29:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1597368568;
	bh=2nL1s/GGGUnkoJ6Qilb5RGZzZJxuT4nGNS/W3kppc2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fSuyijls9JAQcshLNkYvCbwLUGfaDaq6CBB84EIkutZzjy0mUzk+XNeSyIGJOaVMn
	 PKqS2JJaznQ75hg3919YeaV7uIeHMsPsQYiFruGS/FYTEZ3LNnVBeDaUZwHQN37Zg2
	 FmuE2cu9JWjxxKmGOzivUSwPeLyTcgVpUu0hnM9nfZYQ5dUN/obMXINMx6K4Fu0GQu
	 t7CXQStQBS5FduSCcEvYdNbrU3n2iQeipFSyO4rMF4NP6tLgDRbYautmQIW73vxIe3
	 Uvm7MRoMcRnd0N6OnC+5gUeRP9i31lcas92xt6sEaQtRIRzcaqe8t1IBM/FfhaRr1L
	 s1UdEKDma105g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>, Santosh Sivaraj <santosh@fossix.org>, Ira Weiny <ira.weiny@intel.com>, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
In-Reply-To: <13e82e40-35c7-266c-2ec0-5fcdcb5fb27f@linux.ibm.com>
References: <20200813043458.165718-1-vaibhav@linux.ibm.com> <13e82e40-35c7-266c-2ec0-5fcdcb5fb27f@linux.ibm.com>
Date: Fri, 14 Aug 2020 11:29:23 +1000
Message-ID: <87imdm9frg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: ORDS7PRWEZB23SW3KFKX2GGBFWDRBFMH
X-Message-ID-Hash: ORDS7PRWEZB23SW3KFKX2GGBFWDRBFMH
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ORDS7PRWEZB23SW3KFKX2GGBFWDRBFMH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> On 8/13/20 10:04 AM, Vaibhav Jain wrote:
>> The newly introduced 'perf_stats' attribute uses the default access
>> mode of 0444 letting non-root users access performance stats of an
>> nvdimm and potentially force the kernel into issuing large number of
>> expensive HCALLs. Since the information exposed by this attribute
>> cannot be cached hence its better to ward of access to this attribute
>> from users who don't need to access these performance statistics.
>> 
>> Hence this patch adds check in perf_stats_show() to only let users
>> that are 'perfmon_capable()' to read the nvdimm performance
>> statistics.
>> 
>> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/papr_scm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index f439f0dfea7d1..36c51bf8af9a8 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -792,6 +792,10 @@ static ssize_t perf_stats_show(struct device *dev,
>>   	struct nvdimm *dimm = to_nvdimm(dev);
>>   	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
>>   
>> +	/* Allow access only to perfmon capable users */
>> +	if (!perfmon_capable())
>> +		return -EACCES;
>> +
>
> An access check is usually done in open(). This is the read callback IIUC.

Yes. Otherwise an unprivileged user can open the file, and then trick a
suid program into reading from it.

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
