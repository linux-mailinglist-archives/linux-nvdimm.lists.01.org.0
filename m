Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A92DC6E8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 20:14:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BAD6100EBBCC;
	Wed, 16 Dec 2020 11:14:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5354C100EBBCB
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 11:13:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p22so25977871edu.11
        for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFkfbeFrLeAmipwXRTxSy4uN8kMgVXMUvrWdKnqZ51I=;
        b=t61EzBF88rgJVDjwsRzpMeEyXpi+vC34lC89aemqGmJOL29Esk0mYnU4G0zwmXH6K/
         d7JZ336ltsdNb05O5WaKT2fO30SWEcMmbRxIq4qpweHJUD0k95lJQcsJNmhp+HNZEhNx
         G0iCMXhoNebuHMR8DpPDoKjbCzMz2OCBTNi+SQ9EMOCThM0MpUnpcYrhlbBUV4KfV+wF
         ma+3WO/XDp6RS8b8yJXx/pZtDHYtpPf+tPXVAfi1xXb2qDwlYIuLThTOsLzUT7v+qiTh
         k78kxfeJkX5xvdj3yIDdZpa9kqHcrek1IHZksQl2uJhSn2eejV8gorQcM1Nsy7J4za4Q
         h5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFkfbeFrLeAmipwXRTxSy4uN8kMgVXMUvrWdKnqZ51I=;
        b=tobBGMKa/A4GGnpwHetgnCSm9hAJhIQK3w+ZoQqLP7/e1l+J/XJy46lBsRApkQcUeZ
         eNwkJ46BgP/ih5qZbkR7okuEPj2ryi4OnH0jdIoWBuS1pWLwS/soS514MRvavlJKCIUL
         SxVLsB2sQSU83hDKanXhB7nFBKjLq70EeWsroePiFcIVVDnq8nSP4Yr+9ljiA0thEnwW
         OhNddKmtWP5ygCGT5PucEBtTTU5sEF46VMe2EOZNPzJnjGa1v7/bJ1qDdBVKBK46CHdA
         LY+/uXmklpplG6GFynIkJCWaxp81oo/fm6S8/RfbC1ALtPd1RY76V0maVePnymtISIK6
         IX0g==
X-Gm-Message-State: AOAM530/eyE5TR8/8UrcQMu3ppcOjuhsfDg6pWerFsAGjeWRICj8xhNJ
	+QUm6yy2RpjSuRL2FnE8jU/RcVomqfWYfODk/vvD8Q==
X-Google-Smtp-Source: ABdhPJxpCEpivOzqB2v7F4HcEL3EAUhkD7X8lDlzQQV3Q81hLmgHeank0SKfIrISkz/X/CqjTUskdLh5G0m+kJ5M90A=
X-Received: by 2002:a05:6402:1684:: with SMTP id a4mr18448326edv.348.1608146020873;
 Wed, 16 Dec 2020 11:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20200716184707.23018-1-joao.m.martins@oracle.com> <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
In-Reply-To: <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Dec 2020 11:13:30 -0800
Message-ID: <CAPcyv4gWry3r8a46X9pnobFNwjQLqG-N2MyvKsx7abJhjadYTQ@mail.gmail.com>
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping allocation
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: WJU42DKRK7ZEELWVS7Q4VOOISAUPO3VE
X-Message-ID-Hash: WJU42DKRK7ZEELWVS7Q4VOOISAUPO3VE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WJU42DKRK7ZEELWVS7Q4VOOISAUPO3VE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 16, 2020 at 3:41 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 7/16/20 7:46 PM, Joao Martins wrote:
> > Hey,
> >
> > This series builds on top of this one[0] and does the following improvements
> > to the Soft-Reserved subdivision:
> >
> >  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
> >  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
> >
> >  2) Listing improvements for device alignment and mappings;
> >  Note: Perhaps it is better to hide the mappings by default, and only
> >        print with -v|--verbose. This would align with ndctl, as the mappings
> >        info can be quite large.
> >
> >  3) Allow creating devices from selecting ranges. This allows to keep the
> >    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
> >
> >    daxctl list -d dax0.1 > /var/log/dax0.1.json
> >    kexec -d -l bzImage
> >    systemctl kexec
> >    daxctl create -u --restore /var/log/dax0.1.json
> >
> >    The JSON was what I though it would be easier for an user, given that it is
> >    the data format daxctl outputs. Alternatives could be adding multiple:
> >       --mapping <pgoff>:<start>-<end>
> >
> >    But that could end up in a gigantic line and a little more
> >    unmanageable I think.
> >
> > This series requires this series[0] on top of Dan's patches[1]:
> >
> >  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
> >  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
> > The only TODO here is docs and improving tests to validate mappings, and test
> > the restore path.
> >
> > Suggestions/comments are welcome.
> >
> There's a couple of issues in this series regarding daxctl-reconfigure options and
> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.

What's the breakage with older kernels, is it the kernel regressing
old daxctl, or is it new daxctl being incompatible with old kernels?
If it's the latter, it needs a fixup, if it's the former it needs a
kernel compat change.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
