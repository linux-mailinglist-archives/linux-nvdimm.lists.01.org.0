Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E27EE7CC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 19:58:42 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6628B100EA536;
	Mon,  4 Nov 2019 11:01:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D16AE100EEBAC
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 11:01:26 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id v186so15114742oie.5
        for <linux-nvdimm@lists.01.org>; Mon, 04 Nov 2019 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWgg9dEMPr1LYgyhqyBztIJGY700IruaZ3Q4BXheThM=;
        b=batUh0FJihu0Ms2agFem/hzDMy/Hy+8p09z21T1A1mhpgZMo89nn6yHZy9PW+ITkOU
         246EjntFVTK/jzF6hubjealem0B1zxKXCDlI0+F4DMKerfFMLJftmHXEKpWNuiKTuKmZ
         Fzg5hoEuv6ndwW8r4zMZlEGH0qUSnuMhSFEmKlhnW4geog2uN2hWXm+/c2KT0WDU2l7n
         +ieOIAKRIATSmsiDtsTPgVAAVsubufhWvIpv6FHD7JFRsV261/PXKEnHIHOhXaofvcYZ
         nohSbj6Z4d8WZxbCKzS+nDDJJw+FxforXx4197vxce3CWWs9ZeqHq1lpteVJTS6yfXAG
         GusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWgg9dEMPr1LYgyhqyBztIJGY700IruaZ3Q4BXheThM=;
        b=PRoJxovv7TAAq1EF6vW97qamw/1tYSHTnBqm6yka+/u4cJ9AtQ3PvV76Suq2CwVFwk
         gx0T29Ww6ija8sYbQ4VEYHNMx8a84UUsAIcP6R1eQPT37nYyyu+7yR6J6cnA2SYDS/RV
         LfoiOapmFQEExb7feyqFRPl2NpgubsjB4Pk3YrmKyIxerqOG8LwfULxwKnZbRtDS5zBD
         uLdK025xvzXPTmn8LFnYpG0HINvjqFx8XvMbpWw2hcSN9YzJrEWMe7DcG6M2pL94zey5
         eh12E2ckjzoc6ef2mLtPKT0DPLAQV0AM5KoZfpY5mWPo7fRi+eE7BUxVvu+MiBe9Bypy
         2b7Q==
X-Gm-Message-State: APjAAAUqtVmLJaN3xfnvA7kdzdKfMo0vWsPHDVU+eURMwSEs34pU/2I5
	N8BvY0TJuA1q8GuYn60vFg6uDqGXq0Fk9hio66Ukhw==
X-Google-Smtp-Source: APXvYqyljJSP56hbQJQHVgVCe9kAcvwMk1PhWQa+K2Y23BDYg8TQjiE9r9NjHCPUu98SkUvqbuA0zcI/fuDXeOiNAZM=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr453148oia.70.1572893917043;
 Mon, 04 Nov 2019 10:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20191101202713.5111-1-vishal.l.verma@intel.com>
 <20191101202713.5111-2-vishal.l.verma@intel.com> <CAPcyv4jWXXUgjd-_hsP+sUjBRfwQZQQOSUHUqSrdEYzfz3oS-g@mail.gmail.com>
 <4e09051006f7714344c1d230061de0cfcb5377a9.camel@intel.com>
In-Reply-To: <4e09051006f7714344c1d230061de0cfcb5377a9.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Nov 2019 10:58:26 -0800
Message-ID: <CAPcyv4i5cqOrO6LLPZ2z5xx1xApbHaSvMiNk5CCQQ0ZxOr2hCQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 2/2] ndctl/namespace: introduce ndctl_namespace_is_configurable()
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: DMEXLQER3QHQGDO6NMKZDUPONXOX4DKD
X-Message-ID-Hash: DMEXLQER3QHQGDO6NMKZDUPONXOX4DKD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DMEXLQER3QHQGDO6NMKZDUPONXOX4DKD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 4, 2019 at 10:48 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Mon, 2019-11-04 at 08:35 -0800, Dan Williams wrote:
> > On Fri, Nov 1, 2019 at 1:27 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > > The motivation for this change is that we want to refrain from
> > > (re)configuring what appear to be partially configured namespaces.
> > > Namespaces may end up in a state that looks partially configured when
> > > the kernel isn't able to enable a namespace due to mismatched
> > > PAGE_SIZE expectations. In such cases, ndctl should not treat those
> > > as unconfigured 'seed' namespaces, and reuse them.
> > >
> > > Add a new ndctl_namespace_is_configurable API, whish tests whether a
> > > namespaces is active, and whether it is partially configured. If neither
> > > are true, then it can be used for (re)configuration. Additionally, deal
> > > with the corner case of ND_DEVICE_NAMESPACE_IO (legacy PMEM) namespaces
> > > by testing whether the size attribute is read-only (which indicates such
> > > a namespace). Legacy namespaces always appear as configured, since their
> > > size cannot be changed, but they are also always re-configurable.
> > >
> > > Use this API in namespace_reconfig() and namespace_create() to enable
> > > this partial configuration detection.
> >
> > A couple comments.... I think it's probably sufficient to just check
> > for ND_DEVICE_NAMESPACE_IO as I don't anticipate we'll ever have more
> > than one namespace type with a read-only size attribute.
>
> Yep I did notice I could do that, but I decided to go to the source of
> it instead of adding another ND_DEVICE_NAMESPACE_IO assumption. Also I
> had already written sysfs_attr_writable() before I noticed that :)
> But there are already assumptions around ND_DEVICE_NAMESPACE_IO, so
> adding another one here is fine.
>
> > Also, how about s/ndctl_namespace_is_configurable/ndctl_namespace_is_configuration_idle/?
> > Because to me all namespaces are always "configurable", but some may
> > have active non-default properties set.
>
> Sounds reasonable, but how about ndctl_namespace_has_partial_config(),
> which I think describes the situation better, and makes it
> straightforward for a potential future --really-force (or -ff) option
> where we might still want to blow away anything on this namespace and
> reclaim it.

Does "_has_partial_config()" imply "_has_full_config()"? In other
words, what ndctl cares about are namespaces that can effectively be
used as seeds with no existing configuration parameters having been
set. So "_is_configuration_idle()" seems unambiguous where
"_has_partial_config()" does not.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
