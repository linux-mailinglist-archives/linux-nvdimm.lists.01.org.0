Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA6EE5706
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 01:26:49 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78298100EA600;
	Fri, 25 Oct 2019 16:27:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C1D2E100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 16:27:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t8so5780904qtc.6
        for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vay0+/tOwvuGdldkMofAcjLI2BE4AscEkszTPRN4SEY=;
        b=Yr9X3tozHo7Ta2X/KE8g+BJ6GtBO4G4YGrbtMuRtHWfhxERwTZ95gueU4376Q9hxTn
         kYZgkr4v5BEtGaypunaUBRXNyfoclCVIvw3D/94NjJHuvL7BAMDz5kHwOTL7ZCDG9i7n
         XndtJug/R/5+zrAPwOIDVSxYFmORoUEFnj75R2KMEzBcS8GCfDlDidjQKXkjDTCSU7wg
         NLsDstPlaTGipPxPDSYEqswl1V4u0/P+LExicnuFaZLYIsmtGqER1MTQMubfU9MaDVb0
         M7kc6aYzwcYdgxDclHORPP8XjdCKnYA3ofzlJUSXXSJAJIJNNOQmyEtF4J2V8asIb+XD
         w1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vay0+/tOwvuGdldkMofAcjLI2BE4AscEkszTPRN4SEY=;
        b=kdx3uUh+7sT6VG2wOqqqQKqt6JuQPe1qHiRaiDzQqqOs2T0RVbi+dUxzgzdNn1+unW
         RP2QFlJwSR+tcoOvkmoEHMW6DUpMvTmf2G2/jBuGpHFhG+yoEIOACGawhy2ozEjoJfee
         KhQQlVKOFJR1G8IOKS20kt3afpGhJbhWyztYER7qiVQNkh2GMdicFGA/WEa4cZJxo0ap
         HrfNz6i6YXrPk90ABule9EY0kj6x/kE7wRAkKFTHMSTtA2e95dhn26SPGP6IymSl9qE0
         0PxsbvRRznmQAXo2yxAKTP+S0V+e655kMx08tHUVv/RcYt4P0FUzLLnvzUtnlal91kzP
         ROPA==
X-Gm-Message-State: APjAAAWAVDtev5vX1wF1szU8dcWwbSQwEhadD+HmwEHv5t7jn/tNra2s
	9MrJGzVw8nLHt9/y4V+nA1/XDfGCCCDLCb/2+FSPMg==
X-Google-Smtp-Source: APXvYqwembtHSvk14R+JEwxF0a+v4h1alHMzw9jrM+QoFz275sxS5nCX7woDI7UZJR1ekNAzDOgygpMfThK3AdVuiRc=
X-Received: by 2002:a0c:8522:: with SMTP id n31mr6041467qva.161.1572045993119;
 Fri, 25 Oct 2019 16:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157150319417.3940762.12887432367621574807.stgit@dwillia2-desk3.amr.corp.intel.com>
 <77f96d5eade3b83e1ef847fd2b5533f3eb0a9cea.camel@intel.com>
 <5e6086c2a48bce222aaedb8bb121bc64bd7fa445.camel@intel.com> <690e59a9ba44cefe73c8b6ce70a92c53af471364.camel@intel.com>
In-Reply-To: <690e59a9ba44cefe73c8b6ce70a92c53af471364.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Oct 2019 16:26:22 -0700
Message-ID: <CAPcyv4jyQ8HR-rwLMD1j03MP-qH=wKdrXeX7X1pkmMR3=QKApg@mail.gmail.com>
Subject: Re: [ndctl PATCH 3/4] test/dax.sh: Validate huge page mappings
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: CNT5HDK3AUPXW24B2OYSQ2CYSQURJ23G
X-Message-ID-Hash: CNT5HDK3AUPXW24B2OYSQ2CYSQURJ23G
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CNT5HDK3AUPXW24B2OYSQ2CYSQURJ23G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 25, 2019 at 3:44 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> > On Wed, 2019-10-23 at 19:33 +0000, Verma, Vishal L wrote:
> > > > @@ -91,4 +111,4 @@ json=$($NDCTL create-namespace -m raw -f -e $dev)
> > > >  eval $(json2var <<< "$json")
> > > >  [ $mode != "fsdax" ] && echo "fail: $LINENO" &&  exit 1
> > >
> > > same comment about quoting "$mode". If 'mode' happens to be empty for
> > > soem reason, we want to fail with the error message - instead the above
> > > will fail with a syntax error.
> >
> > Sorry ignore this - that was a context line..
> >
>
> Hey Dan,
>
> I've applied patches 1-3, with the following fixup to patch 3.
> Patch 4 didn't apply cleanly, if you can resend that I'll queue it up too.

Will do, thanks for the fixups!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
