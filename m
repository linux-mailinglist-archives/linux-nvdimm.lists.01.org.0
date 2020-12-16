Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F412DC9AE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 00:42:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CFC69100EC1CC;
	Wed, 16 Dec 2020 15:42:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A6042100ED4AE
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 15:42:14 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so20620239ejz.5
        for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/05tMjv8rIWg07T4Boer6EyDeh8xYvFZqT68MBwTfg=;
        b=sl/KdGMSnUSakkm2gmhcZEKK7c9zu6KwMMSW9X67ZTO/PU6G8QOuQ28uYLOvz1mEot
         oCLlOhM4TrjW8/rsA3iSMIcoWZvofdYHGDMpzZBdI0ntnwAv/MhEi2FLOZ4Tx7xlS2K1
         +At8mCjIVv91G6Cu8dRap76wZmk8bP/XGQO5xrd/2PAU1l6feHB+Y8Y0Ak9SKNf7Nu4O
         j9b/AWZKZEqHtuI9w7PStpejEj9Q4EPI5eKlFjGdHbDOPLnq0pUMCONcqQnPRjQ/K0sD
         2MlBkDrSXUDD/q/L4Mhk3AdkPrjR1YFZWHAB2ddEnZwogOOahjbtxWgAwd9D9bQWBUHQ
         IMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/05tMjv8rIWg07T4Boer6EyDeh8xYvFZqT68MBwTfg=;
        b=uBCWplFOWf8gP23MJOvN6p49Dox8hgjGZa+95MyqBoFs8opLfu3+DdHmwPFH6IpX1A
         gPpMEV+hGDFOTw7fm1gTSPsenSTyuDXkbwo+qBcQMbjp3yeWy3Vnfp6sYElOM0jswHX8
         oblB6euMHCqXIzXg8cmNKmjY3t9LfEMQPcqppyVvL4A4ZetfA5VN+0c0dcB1FDcXe4cV
         LRy+EPg8yKWQPsu3WfTK8+ISS2uDATvyHnAQM7jH7dUFx6Oj244BslBiaSRwvxGMSCVa
         zqt3EitzUWphznadhyvPTfXGvA7fIciOwuWuQTlEeV2G1+lHWtOcbgT7+RnD3JtWLrD+
         ybZQ==
X-Gm-Message-State: AOAM532eKFv9sgXCwyz7Ej6cnUZ7Lb+SfPxT2on3Y9/PKVA/pD1aDwXA
	0uSKOVKPudib4PPVR8oi7vq5+HF/bI9TkGFFl+QagQ==
X-Google-Smtp-Source: ABdhPJxrkTIHpPliv0QkBp2LrmgCrG+cAc81DrGdhVHseVlpgJMzcjDSh1/YxxmV9BYYlFR+C5W77E9z2GorkASXyN8=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr33432781ejc.472.1608162132604;
 Wed, 16 Dec 2020 15:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com> <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
 <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com> <CAPcyv4jiS07bGi+YRsMjAt37DCNwioTd8cd=LXKxOg-ARTM87g@mail.gmail.com>
 <01b3c6f8-901e-c9c8-6e98-88366d4ecbdd@oracle.com>
In-Reply-To: <01b3c6f8-901e-c9c8-6e98-88366d4ecbdd@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Dec 2020 15:42:00 -0800
Message-ID: <CAPcyv4jQ9ee-o3t_Wy_4K-Nm5Lj6wJKv1pdjvtYQG6eJ3ejUrQ@mail.gmail.com>
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping allocation
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: Z3MKCI7HYJPJTUDJEAC5ER6CHOJMRPZW
X-Message-ID-Hash: Z3MKCI7HYJPJTUDJEAC5ER6CHOJMRPZW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z3MKCI7HYJPJTUDJEAC5ER6CHOJMRPZW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 16, 2020 at 2:54 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 12/16/20 10:31 PM, Dan Williams wrote:
> > On Wed, Dec 16, 2020 at 1:51 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>
> >> On 12/16/20 6:42 PM, Verma, Vishal L wrote:
> >>> On Wed, 2020-12-16 at 11:39 +0000, Joao Martins wrote:
> >>>> On 7/16/20 7:46 PM, Joao Martins wrote:
> >>>>> Hey,
> >>>>>
> >>>>> This series builds on top of this one[0] and does the following improvements
> >>>>> to the Soft-Reserved subdivision:
> >>>>>
> >>>>>  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
> >>>>>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
> >>>>>
> >>>>>  2) Listing improvements for device alignment and mappings;
> >>>>>  Note: Perhaps it is better to hide the mappings by default, and only
> >>>>>        print with -v|--verbose. This would align with ndctl, as the mappings
> >>>>>        info can be quite large.
> >>>>>
> >>>>>  3) Allow creating devices from selecting ranges. This allows to keep the
> >>>>>    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
> >>>>>
> >>>>>    daxctl list -d dax0.1 > /var/log/dax0.1.json
> >>>>>    kexec -d -l bzImage
> >>>>>    systemctl kexec
> >>>>>    daxctl create -u --restore /var/log/dax0.1.json
> >>>>>
> >>>>>    The JSON was what I though it would be easier for an user, given that it is
> >>>>>    the data format daxctl outputs. Alternatives could be adding multiple:
> >>>>>     --mapping <pgoff>:<start>-<end>
> >>>>>
> >>>>>    But that could end up in a gigantic line and a little more
> >>>>>    unmanageable I think.
> >>>>>
> >>>>> This series requires this series[0] on top of Dan's patches[1]:
> >>>>>
> >>>>>  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
> >>>>>  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
> >>>>>
> >>>>> The only TODO here is docs and improving tests to validate mappings, and test
> >>>>> the restore path.
> >>>>>
> >>>>> Suggestions/comments are welcome.
> >>>>>
> >>>> There's a couple of issues in this series regarding daxctl-reconfigure options and
> >>>> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
> >>>> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.
> >>>>
> >>>> I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
> >>>> in need of feedback.
> >>>
> >>> Sounds good. Any objections to releasing v70 with the initial support,
> >>> and then adding this series on for the next one? I'm thinking I'll do a
> >>> much quicker v72 release say in early January with this and anything
> >>> else that missed v71.
> >>
> >> If we're able to wait until tomorrow, I could respin these first four patches with the
> >> fixes and include the align support in the initial set. Otherwise, I am also good if you
> >> prefer defering it to v72.
> >>
> >
> > Does this change the JSON output? Might be nice to keep that all in
> > one update rather than invalidate some testing with the old format
> > betweem v71 and v72.
> >
> Ugh, sent the v2 too early before seeing this.
>
> The only change to the output is on daxctl when listing devices for 5.10+.
> It starts displaying an "align" key/value.

No worries. Vishal and I chatted and it looks to me like your
improvements to the provisioning flow are worthwhile to sneak into the
v71 release if you want to include those changes as well.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
