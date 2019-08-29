Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD3A251D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 20:28:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C3772021DD4B;
	Thu, 29 Aug 2019 11:30:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 420C32021DD44
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 11:30:33 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g111so1343385otg.9
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jxF3eA6ldWHYL0OkKgPfyOFk47VuOmL/V+bqcE/AEwM=;
 b=G1kaTs/9mp2r7K+A7rRCg9adfq5y6JU/iOj7CBijpQNzvnfklDmBA7wT5Xrb+vDwph
 1nUp/BWLBA32suO/pLQly2l29D905LahgmSqN3giiLI+9xcQ1zeFUsvrbofnT9eHPYdV
 UoRsQNkR+bLQc9CkUq2hXZjf/rrBwXKxHMGDpIc8sAImlXdUx/S1gz6XpbzEDbT54IlM
 N/4kodTLbutoAVE1lgMHJO8bgkCSM63DzMmvw49+y5ztzR7ik26/QwB6BeHmizvRVKMY
 yJgDndAEtyCjzGVAeBURUIw0TDe9De+d4OCA/VnKN1zrmiLpMakqebtNiuLVwbINIcBQ
 XWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jxF3eA6ldWHYL0OkKgPfyOFk47VuOmL/V+bqcE/AEwM=;
 b=IT0EcyCR8Cge/n2Uad6es7Vlmr84JIXRiBJ2qF8po8UvYFEjF2nSVqumG/qC4+m5yr
 F9sCGgB++p1GTsem7I/IHWWxkOvSUEtKwlAnLD5hq/GxsTxEo2MeAtNJhNx6LCfpleTX
 AETHKqL6tjD6/8ptET8Yzc9nPf/DYWYsMuVpRVSx/x+VKOQHv5+d5Aw7YZRAPmAYu6sX
 1wQbVyzQTmN82s4ZstUSMAaZY34NqhyjG9yGCpAPkPf9qfUO+2XZNWfI3LBTbVEF6yac
 X1SFwDVMj0iiNo2CAjrS2zEoH9B3eYVhV26T1aOfB4uk0U89zcit9H2GK63ymlhhsX8q
 Jq7Q==
X-Gm-Message-State: APjAAAVOfBp21HyjVWq1AFHkuMN5a5EO5uV0eWjHW0Bnd4rykcJOCyft
 ZiTJ9vHuMMVeZUW53vQsBzlk/3/1wrZsKSOONKtTFw==
X-Google-Smtp-Source: APXvYqxKZEmiMJv2wTJ5nOo6bct/L8dVyPO9vGQsWE/pi5/9dwLYw2DCrfkvM3Sj64Kpii8dpzWTwziAW7x5+ETnuDM=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr8796080otc.126.1567103320992; 
 Thu, 29 Aug 2019 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
 <179261bd-9812-6bba-6710-19a77cf3acc6@oracle.com>
 <e343ace46d7243632eec594f679759fac78814ba.camel@intel.com>
In-Reply-To: <e343ace46d7243632eec594f679759fac78814ba.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 29 Aug 2019 11:28:29 -0700
Message-ID: <CAPcyv4iQ8=yLGA0E2=puqV+mC7HxNW-RP-0EtVeU2hN6HsNxKQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "Scargall, Steve" <steve.scargall@intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Aug 29, 2019 at 11:08 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Thu, 2019-08-29 at 10:38 -0700, jane.chu@oracle.com wrote:
> > Hi, Vishal,
> >
> >
> > On 8/28/19 5:17 PM, Vishal Verma wrote:
> > > Add a --continue option to ndctl-create-namespaces to allow the creation
> > > of as many namespaces as possible, that meet the given filter
> > > restrictions.
> > >
> > > The creation loop will be aborted if a failure is encountered at any
> > > point.
> >
> > Just wondering what is the motivation behind providing this option?
>
> Hi Jane,
>
> See Steve's email here:
> https://lists.01.org/pipermail/linux-nvdimm/2019-August/023390.html
>
> Essentially it lets sysadmins create a simple, maximal configuration
> without everyone having to script it.

It also gives a touch point to start thinking about parallel namespace
creation. The large advancements in boot time that Alex achieved were
mainly from parallelizing namespace init. With --continue we could
batch the namespace enable calls and kick off a bind thread per
namespace.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
