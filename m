Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24241E1011
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 16:05:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 475AD122338D5;
	Mon, 25 May 2020 07:01:26 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=184.95.58.173; helo=server.jobs-ksa.net; envelope-from=nivashnee.s@samsung.com; receiver=<UNKNOWN> 
Received: from server.jobs-ksa.net (unknown [184.95.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FE4E122338D3
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minsaa.com;
	 s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Reply-To:From:Date:Subject:To:Sender:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QnRRrFL2wD8Y6HpQ80oO8CsQh/hfnivjR/J0kjoGfxw=; b=hvLBbsqXMvsPI0yFoKpuk3hXgL
	LST+a8PMD5DioEq2+xZIDQFlFpi8Rd7EPNURNinBikmOaFZSe00elIL4+rJrnRoX5MnhwBD6csQEx
	u1ygEtpIPO7eY98K5+/sNyUZC21fmemGdz/srQU9z/Q1my5fAzl10LsKvnARfvbnK7yd9tg03uJ7b
	ydrtH4nL41ftEum7so/wucy+iwhV3YmQuIN9bUbIjXAt/uS+Bk28LDsmldtiN2kzNvdvOl1FpWyat
	kzQJWPa8o5AXHEL4+MzZT7b3mty60R+ok/Dx4xBXK4RL6kPbQ1dfhqNDcArtUSEZBMB2t1/jAWIks
	/1hdYEhA==;
Received: from hafr by server.jobs-ksa.net with local (Exim 4.91)
	(envelope-from <nivashnee.s@samsung.com>)
	id 1jdDjE-0005VR-Fw
	for linux-nvdimm@lists.01.org; Mon, 25 May 2020 10:05:20 -0400
To: linux-nvdimm@lists.01.org
Subject: Aw: HG 2020-01/ BL: ONEYNB9BMB197700/ PMT REQUEST
X-PHP-Script: minsaa.com/wp-content/uploads/2016/mail-wp30.php for 35.178.153.58, 184.95.58.173
X-PHP-Originating-Script: 1003:mail-wp30.php
Date: Mon, 25 May 2020 14:05:20 +0000
From: "Nivashnee.s@samsung.com" <nivashnee.s@samsung.com>
Message-ID: <9dcfcda7a81be7ca0189d5b17a9f7638@minsaa.com>
X-Mailer: Leaf PHPMailer 2.7 (leafmailer.pw)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="b1_9dcfcda7a81be7ca0189d5b17a9f7638"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.jobs-ksa.net
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [1003 993] / [47 12]
X-AntiAbuse: Sender Address Domain - samsung.com
X-Get-Message-Sender-Via: server.jobs-ksa.net: authenticated_id: hafr/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: server.jobs-ksa.net: hafr
X-Source: 
X-Source-Args: php-fpm: pool minsaa_com                                 
X-Source-Dir: minsaa.com:/public_html/wp-content/uploads/2016
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 46YSEOU5LITVB762TKBVJ33ULPXZQKNF
X-Message-ID-Hash: 46YSEOU5LITVB762TKBVJ33ULPXZQKNF
X-MailFrom: nivashnee.s@samsung.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: sales01-micargichina@mail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/46YSEOU5LITVB762TKBVJ33ULPXZQKNF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>

This is a multi-part message in MIME format.

--b1_9dcfcda7a81be7ca0189d5b17a9f7638
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--b1_9dcfcda7a81be7ca0189d5b17a9f7638--
