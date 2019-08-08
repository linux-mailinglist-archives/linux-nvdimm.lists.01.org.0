Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0886B53
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Aug 2019 22:21:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1DBD2131BA4C;
	Thu,  8 Aug 2019 13:23:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C1BE5212E4B4C
 for <linux-nvdimm@lists.01.org>; Thu,  8 Aug 2019 13:23:28 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72CF230A5414;
 Thu,  8 Aug 2019 20:20:57 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1157A19C7F;
 Thu,  8 Aug 2019 20:20:56 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch] nfit: report frozen security state
References: <x49k1bw7dqn.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4js-dZWFyRM7=JgC31uJUyxVzuwrderFrWf5p=z82E+WA@mail.gmail.com>
 <x49ef1whcjq.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hUsbFP3=7RFLuHWWnZ+jkUfNFq9YRPKVGk22O7NuP8pA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 08 Aug 2019 16:20:56 -0400
In-Reply-To: <CAPcyv4hUsbFP3=7RFLuHWWnZ+jkUfNFq9YRPKVGk22O7NuP8pA@mail.gmail.com>
 (Dan Williams's message of "Wed, 7 Aug 2019 15:27:35 -0700")
Message-ID: <x498ss3cst3.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 08 Aug 2019 20:20:57 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Dan Williams <dan.j.williams@intel.com> writes:

> ...but ABIs are forever, and ndctl has shipped:
>
>         if (strcmp(buf, "disabled") == 0)
>                 return NDCTL_SECURITY_DISABLED;
>         else if (strcmp(buf, "unlocked") == 0)
>                 return NDCTL_SECURITY_UNLOCKED;
>         else if (strcmp(buf, "locked") == 0)
>                 return NDCTL_SECURITY_LOCKED;
>         else if (strcmp(buf, "frozen") == 0)
>                 return NDCTL_SECURITY_FROZEN;
>         else if (strcmp(buf, "overwrite") == 0)
>                 return NDCTL_SECURITY_OVERWRITE;
>         return NDCTL_SECURITY_INVALID;
>
>
> I think we could break out the frozen state to its own new attribute
> and leave security state to only show "locked" / "unlocked". Then go
> teach new ndctl to go somewhere else to report frozen.

That works for me.

-Jeff
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
