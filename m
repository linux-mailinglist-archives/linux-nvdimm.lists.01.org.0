Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EF2DC8FA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:31:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 412CE100EBB6A;
	Wed, 16 Dec 2020 14:31:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE2E4100EBB69
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:31:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b73so26558308edf.13
        for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh+WAS36xML1zPgv7NdCbB5oZyIGxbqtIdJVn2USyv4=;
        b=WdVYV0cizcLrjwa/EscTumE9UARnCS61mVAGI+16rSO5LsJWm4zZKh/3b+KH0P4RlC
         gglXMwS73Fg6K2E8OLah94u/8fWV4MCe5AVxdyuTf3SPlTA214Rx017CFuNemPGD+AqR
         VVFxPxkeRTADNDW2KAd93j9qzjFxuNmJukXa/nMOo/m7ZMJN9rwW7SS3bpf7AHM4SrUT
         rJPfCZpr2i/KR1Dv92tvofGgfalq/CF9BGGQVnWBMH2KPXS1JRBBDsI8cCQn0e3reEnV
         zkggiR/JuzIurT20Ud/YDxduO4Btv32oQA8Hucn29/DO7IKc6RlLk9Pd5rW69syyr+Ln
         MkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh+WAS36xML1zPgv7NdCbB5oZyIGxbqtIdJVn2USyv4=;
        b=bokZqaDiwVOC2zuw5P+5CmP0i5UGd/Ni8p5uymm0GQeRjI7Rzm7hS5iagF5JPKe2a8
         eFH8r30oOCi4htlwy9yEgd3jckvwLO0Rz1nWZ+2bANVU88Nf7JzopdTS8e+LPAJO2+Gl
         F61hRc8EYbwYJvn6pT9faJu4IAb8MkXU5iO4kZ25WSUqJ1sbgk6kpW9w9O6bg03BTVG6
         weoADsRMJcY3899DsCaf2BNNJAlRR9I/nyMWjx9c3AKxipGE27qSLRgDLW6uoTmuPWut
         X/5kzgkgA8WVJAh/KInGRMe1rvhWa7Xd0sihOhAWg4X+f7dPG1SokxkmCM6lDfxiBDrQ
         GSSw==
X-Gm-Message-State: AOAM533Utrhx45qtSZj8wUcSWR09ygpOHmmuMgDlBKnKG2S+Ifk0A7oG
	3JmmcDG4o4CXZNEpBHYObYXVI7SoObSI2j6Lwq2+/Q==
X-Google-Smtp-Source: ABdhPJxUtRQ/19ImNJcEQZbmD2R/ldwE1np8lf42f4NqRQz5MVFHmLEZorKOAtIL+fIHisKa17h//+slEBL5Q172YdI=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr8761345edw.52.1608157902565;
 Wed, 16 Dec 2020 14:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com> <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
 <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com>
In-Reply-To: <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Dec 2020 14:31:31 -0800
Message-ID: <CAPcyv4jiS07bGi+YRsMjAt37DCNwioTd8cd=LXKxOg-ARTM87g@mail.gmail.com>
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping allocation
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: EYPIKN6FPBAWYRV53TSWV3FGPINB7ZHR
X-Message-ID-Hash: EYPIKN6FPBAWYRV53TSWV3FGPINB7ZHR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EYPIKN6FPBAWYRV53TSWV3FGPINB7ZHR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 16, 2020 at 1:51 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 12/16/20 6:42 PM, Verma, Vishal L wrote:
> > On Wed, 2020-12-16 at 11:39 +0000, Joao Martins wrote:
> >> On 7/16/20 7:46 PM, Joao Martins wrote:
> >>> Hey,
> >>>
> >>> This series builds on top of this one[0] and does the following improvements
> >>> to the Soft-Reserved subdivision:
> >>>
> >>>  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
> >>>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
> >>>
> >>>  2) Listing improvements for device alignment and mappings;
> >>>  Note: Perhaps it is better to hide the mappings by default, and only
> >>>        print with -v|--verbose. This would align with ndctl, as the mappings
> >>>        info can be quite large.
> >>>
> >>>  3) Allow creating devices from selecting ranges. This allows to keep the
> >>>    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
> >>>
> >>>    daxctl list -d dax0.1 > /var/log/dax0.1.json
> >>>    kexec -d -l bzImage
> >>>    systemctl kexec
> >>>    daxctl create -u --restore /var/log/dax0.1.json
> >>>
> >>>    The JSON was what I though it would be easier for an user, given that it is
> >>>    the data format daxctl outputs. Alternatives could be adding multiple:
> >>>     --mapping <pgoff>:<start>-<end>
> >>>
> >>>    But that could end up in a gigantic line and a little more
> >>>    unmanageable I think.
> >>>
> >>> This series requires this series[0] on top of Dan's patches[1]:
> >>>
> >>>  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
> >>>  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
> >>>
> >>> The only TODO here is docs and improving tests to validate mappings, and test
> >>> the restore path.
> >>>
> >>> Suggestions/comments are welcome.
> >>>
> >> There's a couple of issues in this series regarding daxctl-reconfigure options and
> >> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
> >> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.
> >>
> >> I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
> >> in need of feedback.
> >
> > Sounds good. Any objections to releasing v70 with the initial support,
> > and then adding this series on for the next one? I'm thinking I'll do a
> > much quicker v72 release say in early January with this and anything
> > else that missed v71.
>
> If we're able to wait until tomorrow, I could respin these first four patches with the
> fixes and include the align support in the initial set. Otherwise, I am also good if you
> prefer defering it to v72.
>

Does this change the JSON output? Might be nice to keep that all in
one update rather than invalidate some testing with the old format
betweem v71 and v72.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
