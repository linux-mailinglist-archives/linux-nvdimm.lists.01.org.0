Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE621DC72C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 08:49:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFFDA10054ECB;
	Wed, 20 May 2020 23:45:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B5A1100956E7
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 23:44:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 49SKvV6hDcz9sT9;
	Thu, 21 May 2020 16:48:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1590043704;
	bh=mylN82RMn5av9mlUtP03Bq7JN7H0txBfw8gjg+ZMQ7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TD2fDeKCARBDrWHY+VsGAe2iNnjSqQg60E3P1g7BHV/e9JoUek2xU6OXtkwdaFBlG
	 aGsN7rfCMbH628gOSdZXEoRypdxmeNdDtrpbG4z8i41l8g31J3EgJqZna48GJKwC2D
	 5bRYia+7Z03muiVkvkWqj3ePOGlgXK0kW3acfngvbgMdQClEMJRRQ5Z8x3nV+qRPyX
	 EraBdtFn9TliOy7sS163c8RGPhBZnu6NStAC3CIu4NHNsMKW+KtIsGQQxbHCcvH6dx
	 4yVgcFUs0HZ2rGH7IcJSH/rK0vExeIUOkgCbyQhjDX2DlL14cZeT9FW4/IsS3D9Hip
	 vvOPM4L7nSzmA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ira Weiny <ira.weiny@intel.com>, Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [RESEND PATCH v7 4/5] ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-5-vaibhav@linux.ibm.com> <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com>
Date: Thu, 21 May 2020 16:48:40 +1000
Message-ID: <87367t941j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: BOVGGHQ4YTLS35DKKCAIH55BISYAE45Z
X-Message-ID-Hash: BOVGGHQ4YTLS35DKKCAIH55BISYAE45Z
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BOVGGHQ4YTLS35DKKCAIH55BISYAE45Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:
> On Wed, May 20, 2020 at 12:30:57AM +0530, Vaibhav Jain wrote:
>> Introduce support for Papr nvDimm Specific Methods (PDSM) in papr_scm
>> modules and add the command family to the white list of NVDIMM command
>> sets. Also advertise support for ND_CMD_CALL for the dimm
>> command mask and implement necessary scaffolding in the module to
>> handle ND_CMD_CALL ioctl and PDSM requests that we receive.
...
>> + *
>> + * Payload Version:
>> + *
>> + * A 'payload_version' field is present in PDSM header that indicates a specific
>> + * version of the structure present in PDSM Payload for a given PDSM command.
>> + * This provides backward compatibility in case the PDSM Payload structure
>> + * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
>> + *
>> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
>> + * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
>> + * module when servicing the PDSM envelope checks the 'payload_version' and then
>> + * uses 'payload struct version' == MIN('payload_version field',
>> + * 'max payload-struct-version supported by papr_scm') to service the PDSM.
>> + * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
>> + * struct in returned 'payload_version' field.
>
> FWIW many people believe using a size rather than version is more sustainable.
> It is expected that new payload structures are larger (more features) than the
> previous payload structure.
>
> I can't find references at the moment through.

I think clone_args is a good modern example:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sched.h#n88

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
