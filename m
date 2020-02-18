Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB316364C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 23:42:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22FFC10FC3419;
	Tue, 18 Feb 2020 14:43:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7ED6610FC33F6
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 14:43:12 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l136so21872823oig.1
        for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybpo8k31RPGRea3EMtjYTKaXhkIv8RYr2PiaxrIKHMk=;
        b=f2RznJ5muwHYEq0n2JeXTjhQliDZ5mA1ZJAuDi1paBMIR6fCMTCLg3FYWWIEvZwIxR
         GrAH4bBq8YAWHz5lxkc1uLP2ZKyyAoLybXkf51P3QvvLaaXbi55AKM5gbc22ce+DcnRm
         Pe/frnH6nIHEx1kYkimUWorEuVcYkceu9A7YjJfc5vDmDOxs2hdpXWNqkSSmk/WNmKu4
         YGOteTWOQp6fMRKB9+VBjWX9EVqyzmC1m07W42ij2kHmTgU3UMx8xKAju84HuOeCWLqC
         unEB71v3x6z0mmhT34A/HNkDi8Zi/YOBkuObffu7HiIGNpFNvG7Hw9dFKoh+ceUCeKgJ
         hTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybpo8k31RPGRea3EMtjYTKaXhkIv8RYr2PiaxrIKHMk=;
        b=t0iqnCAJvwyC/PzAo2BwL2yoyrCjqnoWCi+hluhz07kmFLXBWpNKJod6UfAA6l6SA3
         sFmVefmJ2YgSZvSHGdniPGcFrZn34eLc3LCeTwuXJabSxCZ5YT24O2/nWUwhCDFnpE0O
         5susrgjcKchszd+D23MVBJWfhCF1ciVfpZwmIZwrC9VGGH4QtpUD5e57gspOt4CPBemv
         VJI036+Kgc3ueB30/xXkjWdTq4hWbq5sTNbf+YRckorjF7VXtffNyfg161NJ03wS3cVr
         pcq7+RBSXbbGpJ6SsxbB1xc50YG07I746sO8GZwUlDcy6NnvYKwXAKXiiJY1zAw7V7LO
         KdYQ==
X-Gm-Message-State: APjAAAX8KoSicsEdEsjCeE6It8lALG+zg2R20X+nBMk5kdVYffOmh4la
	QlD5zdpE0uWfrXW8LoQqeZeNk+s3+reKo+0HA65VDQ==
X-Google-Smtp-Source: APXvYqzq/fWRri4owfNEbnmzCPJYUST/nqryOOwpiAKrwwo+iFoj7zpddsFg1Kk3bqj+Z5CMkzQNYSAnOudkGx8EBmY=
X-Received: by 2002:a54:4791:: with SMTP id o17mr2634622oic.70.1582065738975;
 Tue, 18 Feb 2020 14:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20191206053520.235805-1-santosh@fossix.org> <CAPcyv4gh0yJ62Ki2NWmRDOiinqiv2v_snQ3_JWNhqVMfLCQ6Rg@mail.gmail.com>
 <x49y2sza5g5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49y2sza5g5.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 Feb 2020 14:42:08 -0800
Message-ID: <CAPcyv4j4FrLTuqzyHdwasQHTBcdiRuSyGsxvOY82M9Xw3NNQiA@mail.gmail.com>
Subject: Re: [ndctl V2] namespace/create: Don't create multiple namespaces
 unless greedy
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: N6YV25WBJ33KOM6OTQSLTATUAEVOL2B2
X-Message-ID-Hash: N6YV25WBJ33KOM6OTQSLTATUAEVOL2B2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N6YV25WBJ33KOM6OTQSLTATUAEVOL2B2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 2:36 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> >> index 7fb0007..b1f2158 100644
> >> --- a/ndctl/namespace.c
> >> +++ b/ndctl/namespace.c
> >> @@ -1388,11 +1388,9 @@ static int do_xaction_namespace(const char *namespace,
> >>                                         (*processed)++;
> >>                                         if (param.greedy)
> >>                                                 continue;
> >> -                               }
> >> -                               if (force) {
> >> -                                       if (rc)
> >> +                               } else if (param.greedy && force) {
> >>                                                 saved_rc = rc;
> >> -                                       continue;
> >> +                                               continue;
> >
> > Looks good, applied.
>
> Where?

To the pending queue for v68... that has not been pushed out anywhere.
Were a bit past due for a release. I've been focussed on trying to get
this align issue squared away in the meantime. This is what I have for
the current backlog targeting v68

Auke Kok (3):
      ndctl/build: Do not use `check-news` when `NEWS` file is absent entirely.
      ndctl/build: Ensure header and other misc files are listed.
      ndctl/build: Add `header` as a prereq to Make rule where it is consumed.

Dan Williams (26):
      ndctl/namespace: Clarify that 'reconfigure' == 'destroy+create'
      ndctl/namespace: Fixup man page indentation
      ndctl/list: Add 'target_node' to region and namespace verbose listings
      ndctl/docs: Fix mailing list sign-up link
      ndctl/list: Drop named list objects from verbose listing
      daxctl/list: Avoid memory operations without resource data
      ndctl/build: Fix distcheck
      ndctl/namespace: Fix destroy-namespace accounting relative to seed devices
      ndctl/region: Support ndctl_region_{get,set}_align()
      ndctl/namespace: Improve namespace action failure messages
      ndctl/namespace: Add read-infoblock command
      ndctl/test: Update dax-dev to handle multiple e820 ranges
      ndctl/namespace: Always zero info-blocks
      ndctl/namespace: Disable autorecovery of create-namespace failures
      ndctl/build: Fix EXTRA_DIST already defined errors
      ndctl/test: Checkout device-mapper + dax operation
      ndctl/test: Exercise sub-section sized namespace creation/deletion
      ndctl/namespace: Kill off the legacy mode names
      ndctl/namespace: Introduce mode-to-name and name-to-mode helpers
      ndctl/namespace: Validate namespace size within
validate_namespace_options()
      ndctl/namespace: Clarify 16M minimum size requirement
      ndctl/test: Regression test 'failed to track'
      ndctl/dimm: Rework dimm command status reporting
      ndctl/dimm: Rework iteration to drop unaligned pointers
      ndctl/test: Fix typos / loss of tpm.handle in security test
      ndctl/test: Relax dax_pmem_compat requirement

Ira Weiny (1):
      ndctl: Clean up loop logic in query_fw_finish_status

Santosh Sivaraj (1):
      ndctl/zero-labels: Display error if regions are active

Vaibhav Jain (1):
      namespace/create: Don't create multiple namespaces unless greedy

Vishal Verma (3):
      ndctl/namespace: remove open coded is_namespace_active()
      ndctl/namespace: introduce ndctl_namespace_is_configuration_idle()
      ndctl/README: Update kernel documentation URL

Yi Zhang (1):
      ndctl, test: add bus-id parameter for start-scrub/wait-scrub operation

redhairer (2):
      ndctl, test: add UUID_LIBS for blk_namespaces/pmem_namespaces/device_dax
      daxctl: Change region input type from INTEGER to STRING.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
