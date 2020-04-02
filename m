Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E419C500
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 16:56:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A059810FCBFEF;
	Thu,  2 Apr 2020 07:56:57 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.163.213.48; helo=vps.99businesssolutions.com; envelope-from=rovshen.salyhov@ge.com; receiver=<UNKNOWN> 
Received: from vps.99businesssolutions.com (192-163-213-48.unifiedlayer.com [192.163.213.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F16810FCBFEE
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=foursquaremedia.co.in; s=default; h=Content-Type:MIME-Version:Message-ID:
	Date:Subject:To:From:Reply-To:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Eq9TGwpUMV8TNCnrO7VYXgP5seKxEqW5f2Kw0DhqNuk=; b=eZ1jid6v8aEo+e12rzKcLNQNWy
	clkFGe5vVuUwVYzscMWvwgWWogsvshqFjmOKM5Mx906tt7OASx/ma2DakD1jlKcoPxv0yqd3Y5tNK
	Pxq4T45PeppeRYKJ2ndIKv8d5Oy7Wn3zrF+KU/8HU10YdNEcgSnMpsqadItoWrBuP4mE=;
Received: from [37.49.230.116] (port=65462 helo=ge.com)
	by vps.99businesssolutions.com with esmtpa (Exim 4.92)
	(envelope-from <rovshen.salyhov@ge.com>)
	id 1jK1GD-0004OR-KD
	for linux-nvdimm@lists.01.org; Thu, 02 Apr 2020 20:26:01 +0530
From: rovshen.salyhov@ge.com  <rovshen.salyhov@ge.com>
To: linux-nvdimm@lists.01.org
Subject: Corrections
Date: 02 Apr 2020 16:56:00 +0200
Message-ID: <20200402165600.0881B15499587E1E@ge.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_6534C571.80B1F71D"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps.99businesssolutions.com
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ge.com
X-Get-Message-Sender-Via: vps.99businesssolutions.com: authenticated_id: info@foursquaremedia.co.in
X-Authenticated-Sender: vps.99businesssolutions.com: info@foursquaremedia.co.in
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-ID-Hash: 2JGAUQNQOERVCOFXQSS3FFOVXZKIJWKD
X-Message-ID-Hash: 2JGAUQNQOERVCOFXQSS3FFOVXZKIJWKD
X-MailFrom: rovshen.salyhov@ge.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rovshen.salyhov@ge.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2JGAUQNQOERVCOFXQSS3FFOVXZKIJWKD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0012_6534C571.80B1F71D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

------=_NextPart_000_0012_6534C571.80B1F71D--
